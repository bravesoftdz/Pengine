unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Lists, Vcl.ComCtrls, OpenGLContext;

type
  TfrmMain = class(TForm)
    lbChild: TListBox;
    edtWindowName: TEdit;
    tbTransparency: TTrackBar;
    btnBorderlessFullscreen: TButton;
    cbHideTaskbar: TCheckBox;
    procedure lbChildDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbChildMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure edtWindowNameChange(Sender: TObject);
    procedure edtWindowNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtWindowNameKeyPress(Sender: TObject; var Key: Char);
    procedure tbTransparencyChange(Sender: TObject);
    procedure btnBorderlessFullscreenClick(Sender: TObject);
    procedure cbHideTaskbarClick(Sender: TObject);
  private
    FHandle: HWND;
    FHistory: TArray<HWND>;

    class function EnumFunc(AHandle: HWND; AListBox: TListBox): BOOL; static; stdcall;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnBorderlessFullscreenClick(Sender: TObject);
var
  M: TMonitor;
begin
  if FHandle <> 0 then
  begin
    SetLastError(0);
    if (SetWindowLong(FHandle, GWL_STYLE, WS_VISIBLE) = 0) and (GetLastError <> 0) then
    begin
      ShowMessage('Could not remove Window decorations!');
      Exit;
    end;
    M := Screen.MonitorFromWindow(FHandle);
    if not SetWindowPos(FHandle, 0, 0, 0, M.Width, M.Height, SWP_NOZORDER) then
    begin
      ShowMessage('Could not go to fullscreen!');
      Exit;
    end;
  end;
end;

procedure TfrmMain.cbHideTaskbarClick(Sender: TObject);
var
  H: HWND;
  WL: NativeInt;
begin
  H := FindWindow('Shell_TrayWnd', nil);
  if cbHideTaskbar.Checked then
    ShowWindow(H, SW_HIDE)
  else
    ShowWindow(H, SW_SHOW);
end;

procedure TfrmMain.edtWindowNameChange(Sender: TObject);
begin
  FHandle := FindWindow(nil, @edtWindowName.Text[1]);
  lbChild.Clear;
  if FHandle = 0 then
  begin
    edtWindowName.Font.Color := clRed;
  end
  else
  begin
    edtWindowName.Font.Color := clDefault;
    FHistory.DelAll;
    FHistory.Add(FHandle);
    EnumChildWindows(FHandle, @EnumFunc, LPARAM(lbChild));
  end;
end;

procedure TfrmMain.edtWindowNameKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    edtWindowName.OnChange(Sender);
end;

procedure TfrmMain.edtWindowNameKeyPress(Sender: TObject; var Key: Char);
var
  Old, Sel: Integer;
  T: String;
begin
  if Key = Char(VK_RETURN) then
    Key := #0
  else if Key = #127 then
  begin
    Key := #0;
    Old := edtWindowName.SelStart;
    edtWindowName.Perform(WM_KEYDOWN, VK_LEFT, 0);
    edtWindowName.Perform(WM_KEYUP, VK_LEFT, 0);
    T := edtWindowName.Text;
    Sel := edtWindowName.SelStart;
    Delete(T, Sel + 1, Old - Sel);
    edtWindowName.Text := T;
    edtWindowName.SelStart := Sel;
  end;
end;

class function TfrmMain.EnumFunc(AHandle: HWND; AListBox: TListBox): BOOL;
var
  WindowClass, WindowText: String;
begin
  SetLength(WindowClass, 256);
  SetLength(WindowClass, GetClassName(AHandle, @WindowClass[1], 256));
  SetLength(WindowText, GetWindowTextLength(AHandle));
  GetWindowText(AHandle, @WindowText[1], 256);
  AListBox.AddItem(WindowClass + ': ' + WindowText, TObject(AHandle));
  Result := True;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FHistory := TArray<HWND>.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FHistory.Free;
end;

procedure TfrmMain.lbChildDblClick(Sender: TObject);
var
  H: HWND;
begin
  if lbChild.ItemIndex = -1 then
    Exit;
  H := HWND(lbChild.Items.Objects[lbChild.ItemIndex]);
  lbChild.Clear;
  FHistory.Add(H);
  EnumChildWindows(H, @EnumFunc, LPARAM(lbChild));
end;

procedure TfrmMain.lbChildMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbRight) and (FHistory.Count > 1) then
  begin
    lbChild.Clear;
    FHistory.DelLast;
    EnumChildWindows(FHistory.Last, @EnumFunc, LPARAM(lbChild));
  end;
end;

procedure TfrmMain.tbTransparencyChange(Sender: TObject);
var
  WL: NativeInt;
  E: BOOL;
begin
  if FHandle <> 0 then
  begin
    WL := GetWindowLong(FHandle, GWL_EXSTYLE);
    if (WL and WS_EX_LAYERED) = 0 then
    begin
      WL := WL or WS_EX_LAYERED;
      SetLastError(0);
      if (SetWindowLong(FHandle, GWL_EXSTYLE, WL) = 0) and (GetLastError <> 0) then
      begin
        ShowMessage('Could not make Window transparent!');
        Exit;
      end;
    end;
    if not SetLayeredWindowAttributes(FHandle, RGB(0, 0, 0), tbTransparency.Position, LWA_ALPHA) then
      ShowMessage('Could not update transparency!');
  end;
end;

end.
