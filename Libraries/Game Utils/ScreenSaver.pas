unit ScreenSaver;

interface

uses
  Windows, SysUtils, dglOpenGL, Graphics;

type

  { TScreenSaver }

  TScreenSaver = class
  private
    procedure Start;
    procedure Preview(AHandle: HWND);
    procedure Options(AHandle: HWND);

  public
    constructor Create;
    destructor Destroy; override;

    procedure Execute;
  end;

implementation

{ TScreenSaver }

procedure TScreenSaver.Start;
begin

end;

procedure TScreenSaver.Preview(AHandle: HWND);
var
  DC: HDC;
  RC: HGLRC;
  WinRect: RECT;
  Text: String;
  X1, X2: Integer;
  Data: longint;
begin
  InitOpenGL;

  DC := GetDC(AHandle);
  Data := GetWindowLong(AHandle, GWL_STYLE);
  Data := Data or WS_THICKFRAME;
  SetWindowLong(AHandle, GWL_STYLE, Data);
  LineTo();

  {
  RC := CreateRenderingContextVersion(DC, [opDoubleBuffered], 4, 2, True, 32, 24, 0, 0, 0, 0);
  ActivateRenderingContext(DC, RC);

  GetWindowRect(AHandle, WinRect);

  ();

  //Text := Format('Screen Scale: %x', [Data]);
  //MessageBox(AHandle, PChar(Text), 'Info', 0);

  glViewport(0, 0, WinRect.Right - WinRect.Left, WinRect.Bottom - WinRect.Top);

  while GetAsyncKeyState(VK_SPACE) = 0 do
  begin
    glClearColor((GetTickCount64 mod 1000) / 1000, 1, 0, 1);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    SwapBuffers(DC);
  end;

  DeactivateRenderingContext;
  DestroyRenderingContext(RC);
  }
  ReleaseDC(AHandle, DC);
end;

procedure TScreenSaver.Options(AHandle: HWND);
begin

end;

constructor TScreenSaver.Create;
begin

end;

destructor TScreenSaver.Destroy;
begin
  inherited Destroy;
end;

procedure TScreenSaver.Execute;
var
  MainParam: String;
begin
  MainParam := LowerCase(ParamStr(1));

  if (ParamCount < 1) or (MainParam[1] <> '/') or (Length(MainParam) < 2) then
  begin
    MessageBox(0, 'Not started corretcly!', 'Error', MB_ICONERROR);
    Exit;
  end;

  if MainParam[2] = 's' then
  begin
    Start
  end
  else if MainParam[2] = 'p' then
  begin
    Preview(StrToInt(ParamStr(2)));
  end
  else if MainParam[2] = 'o' then
  begin
    Options(0);
  end;
end;

end.
