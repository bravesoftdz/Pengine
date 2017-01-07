unit ControlledCamera;

interface

uses
  Classes, SysUtils, Camera, InputHandler, Controls, VectorGeometry, Windows, OpenGLContext
  {$IFNDEF FPC}
  , UITypes
  {$ENDIF};

type

  TRequestLockPointFunction = function(out APoint: TGVector3): Boolean of object;

  { TControlledCamera }

  TControlledCamera = class (TCamera)
  private
    FInput: TInputHandler;
    FMoving: Boolean;

    FOldMousePos: TGVector2;

    FResetLocation: TLocation;

    FLowerLimit, FUpperLimit: TGVector3;
    FZoomLowerLimit: Single;
    FZoomSpeed: Single;
    FZoomUpperLimit: Single;
    FPitchLowerLimit: Single;
    FPitchUpperLimit: Single;

    FGetLockPoint: TRequestLockPointFunction;
    FLockPointOnFront: Boolean;
    FLockPointEnabled: Boolean;
    FLockPointRadius: Single;
    FLockPointStart: TGDirection;
    FSaveCamTurn, FSaveCamPitch, FSaveCamRoll: Single;

    function GetLockPointDirection: TGDirection;

    procedure SetLowerLimit(AValue: TGVector3);
    procedure SetLowerLimitX(AValue: Single);
    procedure SetLowerLimitY(AValue: Single);
    procedure SetLowerLimitZ(AValue: Single);
    procedure SetPitchLowerLimit(AValue: Single);
    procedure SetPitchUpperLimit(AValue: Single);
    procedure SetUpperLimit(AValue: TGVector3);
    procedure SetUpperLimitX(AValue: Single);
    procedure SetUpperLimitY(AValue: Single);
    procedure SetUpperLimitZ(AValue: Single);
    procedure SetZoomLowerLimit(AValue: Single);
    procedure SetZoomUpperLimit(AValue: Single);

    procedure DoMovement;

  public
    constructor Create(FOV, Aspect, NearClip, FarClip: Single; AInput: TInputHandler);
    destructor Destroy; override;

    property Moving: Boolean read FMoving;

    procedure SetReset; overload;
    procedure SetReset(FPos, FOffset, FScale: TGVector; FTurn, FPitch: Single; FRoll: Single = 0); overload;
    procedure Reset;

    property PosLowerLimit: TGVector3 read FLowerLimit write SetLowerLimit;
    property PosLowerLimitX: Single read FLowerLimit.X write SetLowerLimitX;
    property PosLowerLimitY: Single read FLowerLimit.Y write SetLowerLimitY;
    property PosLowerLimitZ: Single read FLowerLimit.Z write SetLowerLimitZ;
    property PosUpperLimit: TGVector3 read FUpperLimit write SetUpperLimit;
    property PosUpperLimitX: Single read FUpperLimit.X write SetUpperLimitX;
    property PosUpperLimitY: Single read FUpperLimit.Y write SetUpperLimitY;
    property PosUpperLimitZ: Single read FUpperLimit.Z write SetUpperLimitZ;
    property PitchUpperLimit: Single read FPitchUpperLimit write SetPitchUpperLimit;
    property PitchLowerLimit: Single read FPitchLowerLimit write SetPitchLowerLimit;

    property ZoomSpeed: Single read FZoomSpeed write FZoomSpeed;

    property ZoomLowerLimit: Single read FZoomLowerLimit write SetZoomLowerLimit;
    property ZoomUpperLimit: Single read FZoomUpperLimit write SetZoomUpperLimit;

    property GetLockPoint: TRequestLockPointFunction write FGetLockPoint;

    procedure Update; virtual;
  end;

  { TSmoothControlledCamera }

  TSmoothControlledCamera = class (TControlledCamera)
  private
    FVisibleLocation: TLocation;
    FGLForm: TGLForm;
    FSmoothSpeed: Single;

  protected
    function GetLocation: TLocation; override;
  public
    constructor Create(FOV, Aspect, NearClip, FarClip: Single; AGLForm: TGLForm);
    destructor Destroy; override;

    procedure HardReset;

    property SmoothSpeed: Single read FSmoothSpeed write FSmoothSpeed;
    property EndLocation: TLocation read FLocation;

    procedure Update; override;
  end;

implementation

uses
  Math;

const
  MouseSensitivity = 200;

{ TSmoothControlledCamera }

procedure TSmoothControlledCamera.Update;
begin
  inherited Update;
  FVisibleLocation.Approach(FLocation, 1 - exp(-FSmoothSpeed * FGLForm.DeltaTime));
end;

function TSmoothControlledCamera.GetLocation: TLocation;
begin
  Result := FVisibleLocation;
end;

constructor TSmoothControlledCamera.Create(FOV, Aspect, NearClip, FarClip: Single; AGLForm: TGLForm);
begin
  FGLForm := AGLForm;
  FVisibleLocation := TLocation.Create(True);
  FSmoothSpeed := 20;
  inherited Create(FOV, Aspect, NearClip, FarClip, AGLForm.Input);
end;

destructor TSmoothControlledCamera.Destroy;
begin
  FVisibleLocation.Free;
  inherited Destroy;
end;

procedure TSmoothControlledCamera.HardReset;
begin
  Reset;
  FVisibleLocation.Assign(EndLocation);
end;

{ TControlledCamera }

procedure TControlledCamera.DoMovement;
var
  DeltaMouse: TGVector2;
  LockPoint: TGVector3;
  LockPointCurrent: TGDirection;
begin
  with FInput do
  begin
    if ButtonPressed(mbRight) or ButtonPressed(mbLeft) then
    begin
      FOldMousePos := FInput.MousePos;
      if KeyDown(VK_SHIFT) and not KeyDown(VK_CONTROL) then
      begin
        if Assigned(FGetLockPoint) and FGetLockPoint(LockPoint) then
        begin
          FSaveCamTurn := FLocation.TurnAngle;
          FSaveCamPitch := FLocation.PitchAngle;
          FSaveCamRoll := FLocation.RollAngle;
          FLockPointRadius := FLocation.Pos.DistanceTo(LockPoint);
          FLockPointOnFront := FLocation.Look.Dot(FLocation.Pos.VectorTo(LockPoint)) <= 0;
          FLockPointStart := GetLockPointDirection;
          FLockPointEnabled := True;
        end
        else
          FLockPointEnabled := False;
      end;
    end;

    DeltaMouse := FInput.MousePos - FOldMousePos;

    if KeyDown(VK_SHIFT) then
    begin
      if KeyDown(VK_CONTROL) then
      begin
        // Alt Mode
        if ButtonDown(mbRight) then
        begin
          FLocation.Turn(MouseSensitivity * DeltaMouse.X);
          FLocation.Lift(-FLocation.OffsetZ * DeltaMouse.Y, True);
        end
        else if ButtoNDown(mbLeft) then
          SlideMove(-FLocation.OffsetZ * DeltaMouse);
      end
      else
      begin
        // Locked Mode
        if ButtonDown(mbRight) and FLockPointEnabled then
        begin
          LockPointCurrent := GetLockPointDirection;
          FLocation.TurnAngle := FSaveCamTurn +
            (LockPointCurrent.TurnAngle - FLockPointStart.TurnAngle);
          FLocation.PitchAngle := FSaveCamPitch +
            (LockPointCurrent.PitchAngle - FLockPointStart.PitchAngle);
        end;
      end;
    end
    else
    begin
      // Normal Mode
      if ButtonDown(mbRight) then
        TurnPitch(MouseSensitivity * DeltaMouse)
      else if ButtonDown(mbLeft) then
        SlideLift(-FLocation.OffsetZ * DeltaMouse);
    end;

    if ButtonDown(mbLeft) or buttonDown(mbRight) then
      FOldMousePos := FInput.MousePos;

    FLocation.Pos := TGVector3.Create(
      EnsureRange(FLocation.Pos.X, FLowerLimit.X, FUpperLimit.X),
      EnsureRange(FLocation.Pos.Y, FLowerLimit.Y, FUpperLimit.Y),
      EnsureRange(FLocation.Pos.Z, FLowerLimit.Z, FUpperLimit.Z)
    );

    FLocation.PitchAngle := EnsureRange(FLocation.PitchAngle, FPitchLowerLimit, FPitchUpperLimit);

    if ScrolledUp then
      FLocation.OffsetZ := Max(FLocation.OffsetZ / (1 + FZoomSpeed), FZoomLowerLimit);
    if ScrolledDown then
      FLocation.OffsetZ := FLocation.OffsetZ * (1 + FZoomSpeed);

    FLocation.OffsetZ := Min(FLocation.OffsetZ, FZoomUpperLimit);

  end;
end;

function TControlledCamera.GetLockPointDirection: TGDirection;
var
  L: TGLine;
  Data: TGLine.TOrthoProjData;
  D, P: Single;
  OldT, OldP, OldR: Single;
begin
  OldT := Location.TurnAngle;
  OldP := Location.PitchAngle;
  OldR := Location.RollAngle;

  Location.TurnAngle := FSaveCamTurn;
  Location.PitchAngle := FSaveCamPitch;
  Location.RollAngle := FSaveCamRoll;

  L := GetCursorLine(FInput.MousePos);

  Location.TurnAngle := OldT;
  Location.PitchAngle := OldP;
  Location.RollAngle := OldR;

  L.SV := L.SV - FLocation.Pos;
  L.DV := L.DV.Normalize * FLockPointRadius;
  L.OrthoProj(Origin, Data);
  P := Data.Height / FLockPointRadius; // percentage (0 = on sphere-middle, 1 = on sphere-side)

  if P >= 1 then
  begin
    // Try changing the line, so it fits perfectly on the circle
    P := 1;
  end;

  D := Sqrt(1 - Sqr(P));
  if FLockPointOnFront then
    D := Data.Distance - D
  else
    D := Data.Distance + D;

  Result := TGDirection.FromVector(L.GetPoint(D));
  if not FLockPointOnFront then
  begin
    Result.T := Result.T + Pi;
    Result.P := -Result.P;
  end;
end;

procedure TControlledCamera.SetLowerLimit(AValue: TGVector3);
begin
  if FLowerLimit = AValue then
    Exit;
  FLowerLimit := AValue;
  Location.Pos := TGVector3.Create(
    Max(Location.Pos.X, AValue.X),
    Max(Location.Pos.Y, AValue.Y),
    Max(Location.Pos.Z, AValue.Z)
  );
end;

procedure TControlledCamera.SetLowerLimitX(AValue: Single);
begin
  if FLowerLimit.X = AValue then
    Exit;
  FLowerLimit.X := AValue;
  Location.PosX := Max(Location.Pos.X, AValue);
end;

procedure TControlledCamera.SetLowerLimitY(AValue: Single);
begin
  if FLowerLimit.Y = AValue then
    Exit;
  FLowerLimit.Y := AValue;
  Location.PosY := Max(Location.Pos.Y, AValue);
end;

procedure TControlledCamera.SetLowerLimitZ(AValue: Single);
begin
  if FLowerLimit.Z = AValue then
    Exit;
  FLowerLimit.Z := AValue;
  Location.PosZ := Max(Location.Pos.Z, AValue);
end;

procedure TControlledCamera.SetPitchLowerLimit(AValue: Single);
begin
  if FPitchLowerLimit = AValue then
    Exit;
  FPitchLowerLimit := AValue;
  Location.PitchAngle := Max(Location.PitchAngle, AValue);
end;

procedure TControlledCamera.SetPitchUpperLimit(AValue: Single);
begin
  if FPitchUpperLimit = AValue then
    Exit;
  FPitchUpperLimit := AValue;
  Location.PitchAngle := Min(Location.PitchAngle, AValue);
end;

procedure TControlledCamera.SetUpperLimit(AValue: TGVector3);
begin
  if FUpperLimit = AValue then
    Exit;
  FUpperLimit := AValue;
  Location.Pos := TGVector3.Create(
    Min(Location.Pos.X, AValue.X),
    Min(Location.Pos.Y, AValue.Y),
    Min(Location.Pos.Z, AValue.Z)
  );
end;

procedure TControlledCamera.SetUpperLimitX(AValue: Single);
begin
  if FUpperLimit.X = AValue then
    Exit;
  FUpperLimit.X := AValue;
  Location.PosX := Min(Location.Pos.X, AValue);
end;

procedure TControlledCamera.SetUpperLimitY(AValue: Single);
begin
  if FUpperLimit.Y = AValue then
    Exit;
  FUpperLimit.Y := AValue;
  Location.PosY := Min(Location.Pos.Y, AValue);
end;

procedure TControlledCamera.SetUpperLimitZ(AValue: Single);
begin
  if FUpperLimit.Z = AValue then
    Exit;
  FUpperLimit.Z := AValue;
  Location.PosZ := Min(Location.Pos.Z, AValue);
end;

procedure TControlledCamera.SetZoomLowerLimit(AValue: Single);
begin
  if AValue <= 0 then
    raise Exception.Create('Zoom-Limit must be greater than zero!');
  if FZoomLowerLimit = AValue then
    Exit;
  FZoomLowerLimit := AValue;
  Location.OffsetZ := Max(Location.OffsetZ, AValue);
end;

procedure TControlledCamera.SetZoomUpperLimit(AValue: Single);
begin
  if FZoomUpperLimit = AValue then
    Exit;
  FZoomUpperLimit := AValue;
  Location.OffsetZ := Min(Location.OffsetZ, AValue);
end;

constructor TControlledCamera.Create(FOV, Aspect, NearClip, FarClip: Single; AInput: TInputHandler);
begin
  inherited Create(FOV, Aspect, NearClip, FarClip);

  FInput := AInput;
  FResetLocation := TLocation.Create;

  PosLowerLimit := -InfVec;
  PosUpperLimit := +InfVec;

  PitchLowerLimit := -90;
  PitchUpperLimit := +90;

  ZoomLowerLimit := 0.1;
  ZoomUpperLimit := Infinity;
  ZoomSpeed := 0.1;
end;

destructor TControlledCamera.Destroy;
begin
  FResetLocation.Free;
  inherited;
end;

procedure TControlledCamera.SetReset;
begin
  FResetLocation.Pos := FLocation.Pos;
  FResetLocation.Offset := FLocation.Offset;
  FResetLocation.Scale := FLocation.Scale;
  FResetLocation.TurnAngle := FLocation.TurnAngle;
  FResetLocation.PitchAngle := FLocation.PitchAngle;
  FResetLocation.RollAngle := FLocation.RollAngle;
end;

procedure TControlledCamera.SetReset(FPos, FOffset, FScale: TGVector; FTurn, FPitch: Single; FRoll: Single);
begin
  FResetLocation.Pos := FPos;
  FResetLocation.Offset := FOffset;
  FResetLocation.Scale := FScale;
  FResetLocation.TurnAngle := FTurn;
  FResetLocation.PitchAngle := FPitch;
  FResetLocation.RollAngle := FRoll;
end;

procedure TControlledCamera.Reset;
begin
  FLocation.Pos := FResetLocation.Pos;
  FLocation.Offset := FResetLocation.Offset;
  FLocation.Scale := FResetLocation.Scale;
  FLocation.TurnAngle := FResetLocation.TurnAngle;
  FLocation.PitchAngle := FResetLocation.PitchAngle;
  FLocation.RollAngle := FResetLocation.RollAngle;
end;

procedure TControlledCamera.Update;
begin
  if (FInput.AsyncKeyDown(VK_CONTROL) or FInput.AsyncKeyDown(VK_SHIFT)) and
      FInput.ButtonUp(mbLeft) and FInput.ButtonUp(mbRight) then
    FMoving := True
  else if (FInput.AsyncKeyUp(VK_CONTROL) and FInput.AsyncKeyUp(VK_SHIFT)) then
    FMoving := False;

  if FMoving then
    DoMovement;
end;

end.
