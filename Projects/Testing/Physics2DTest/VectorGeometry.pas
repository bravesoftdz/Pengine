unit VectorGeometry;

interface

uses
  Matrix, SysUtils, Math, MathUtils;

type
  TSingleArray = array of Single;

  TGCoordAxis = (caX, caY, caZ);

  TGBasicDir = (sdNone, sdRight, sdLeft, sdUp, sdDown, sdFront, sdBack);

  TGBasicDir3 = sdRight..sdBack;
  TGBasicDir2 = sdRight..sdDown;
  TGBasicDir1 = sdRight..sdLeft;

  TGBasicDirs = set of TGBasicDir;
  TGBasicDirs3 = set of TGBasicDir3;
  TGBasicDirs2 = set of TGBasicDir2;
  TGBasicDirs1 = set of TGBasicDir1;

  TQuadSide = 0 .. 5;
  TTriangleSide = 0 .. 2;

  { TGVector }

  TGVector = record
    X, Y, Z, W: Single;

    class operator Add(const A, B: TGVector): TGVector;
    class operator Subtract(const A, B: TGVector): TGVector;

    class operator Add(const A: TGVector; const V: Single): TGVector;
    class operator Subtract(const A: TGVector; const V: Single): TGVector;

    class operator Multiply(const A: TGVector; const V: Single): TGVector;
    class operator Multiply(const V: Single; const A: TGVector): TGVector;
    class operator Multiply(const A, B: TGVector): TGVector;

    class operator Multiply(const A: TMatrix4; const B: TGVector): TGVector;
    class operator Multiply(const B: TGVector; const A: TMatrix4): TGVector;

    class operator Divide(const A: TGVector; const V: Single): TGVector;
    class operator Divide(const V: Single; const A: TGVector): TGVector;
    class operator Divide(const A, B: TGVector): TGVector;

    class operator Positive(const A: TGVector): TGVector;
    class operator Negative(const A: TGVector): TGVector;

    class operator Equal(const A, B: TGVector): Boolean;
    class operator NotEqual(const A, B: TGVector): Boolean;
    class operator LessThan(const A, B: TGVector): Boolean;
    class operator LessThanOrEqual(const A, B: TGVector): Boolean;
    class operator GreaterThan(const A, B: TGVector): Boolean;
    class operator GreaterThanOrEqual(const A, B: TGVector): Boolean;

    class operator Implicit(const A: TGVector): String;

    function Cross(const A: TGVector): TGVector;
    function Dot(const A: TGVector): Single;
    function SqrDot: Single;
    function Length: Single;
    function DistanceTo(const A: TGVector): Single;
    function VectorTo(const A: TGVector): TGVector;
    function Normalize: TGVector;
    function Abs: TGVector;
    function GetCosAngle(const A: TGVector): Single;
    function AngleTo(const A: TGVector): Single;
    function Floor: TGVector;
    function Ceil: TGVector;

    function ToString: String;

    function Rotate(A: TGVector; Angle: Single): TGVector;

    constructor Create(const X, Y, Z: Single; const W: Single = 1);

    property S: Single read X write X;
    property T: Single read Y write Y;
    property U: Single read Z write Z;
    property V: Single read W write W;
  end;

  TGVector4 = TGVector;

  { TGVector3 }

  TGVector3 = record
    X, Y, Z: Single;

    class operator Add(const A, B: TGVector3): TGVector3;
    class operator Subtract(const A, B: TGVector3): TGVector3;

    class operator Add(const A: TGVector3; const V: Single): TGVector3;
    class operator Subtract(const A: TGVector3; const V: Single): TGVector3;

    class operator Multiply(const V: Single; const A: TGVector3): TGVector3;
    class operator Multiply(const A: TGVector3; const V: Single): TGVector3;
    class operator Multiply(const A, B: TGVector3): TGVector3;

    class operator Multiply(const A: TMatrix3; const B: TGVector3): TGVector3;
    class operator Multiply(const B: TGVector3; const A: TMatrix3): TGVector3;

    class operator Divide(const V: Single; const A: TGVector3): TGVector3;
    class operator Divide(const A: TGVector3; const V: Single): TGVector3;
    class operator Divide(const A, B: TGVector3): TGVector3;

    class operator Positive(const A: TGVector3): TGVector3;
    class operator Negative(const A: TGVector3): TGVector3;

    class operator Equal(const A, B: TGVector3): Boolean;
    class operator NotEqual(const A, B: TGVector3): Boolean;
    class operator LessThan(const A, B: TGVector3): Boolean;
    class operator LessThanOrEqual(const A, B: TGVector3): Boolean;
    class operator GreaterThan(const A, B: TGVector3): Boolean;
    class operator GreaterThanOrEqual(const A, B: TGVector3): Boolean;

    class operator Implicit(const A: TGVector4): TGVector3;
    class operator Implicit(const A: TGVector3): TGVector4;

    class operator Implicit(const A: TGVector3): String;

    function ToVec4(const W: Single = 1): TGVector4;

    function Cross(const A: TGVector3): TGVector3;
    function Dot(const A: TGVector3): Single;
    function SqrDot: Single;
    function Length: Single;
    function DistanceTo(const A: TGVector3): Single;
    function VectorTo(A: TGVector3): TGVector3;
    function Normalize: TGVector3;
    function Abs: TGVector3;
    function GetCosAngle(const A: TGVector3): Single;
    function AngleTo(const A: TGVector3): Single;
    function Floor: TGVector3;
    function Ceil: TGVector3;
    function MirrorOther(const A: TGVector3): TGVector3;

    function ToString: String;

    function Rotate(A: TGVector3; Angle: Single): TGVector3;

    constructor Create(const X, Y, Z: Single);
    class function Random: TGVector3; static;

    property S: Single read X write X;
    property T: Single read Y write Y;
    property U: Single read Z write Z;
  end;

  { TGVector2 }

  TGVector2 = record
    X, Y: Single;

    class operator Add(const A, B: TGVector2): TGVector2;
    class operator Subtract(const A, B: TGVector2): TGVector2;

    class operator Add(const A: TGVector2; const V: Single): TGVector2;
    class operator Subtract(const A: TGVector2; const V: Single): TGVector2;

    class operator Multiply(const V: Single; const A: TGVector2): TGVector2;
    class operator Multiply(const A: TGVector2; const V: Single): TGVector2;
    class operator Multiply(const A, B: TGVector2): TGVector2;

    class operator Divide(const V: Single; const A: TGVector2): TGVector2;
    class operator Divide(const A: TGVector2; const V: Single): TGVector2;
    class operator Divide(const A, B: TGVector2): TGVector2;

    class operator Positive(const A: TGVector2): TGVector2;
    class operator Negative(const A: TGVector2): TGVector2;

    class operator Equal(const A, B: TGVector2): Boolean;
    class operator NotEqual(const A, B: TGVector2): Boolean;
    class operator LessThan(const A, B: TGVector2): Boolean;
    class operator LessThanOrEqual(const A, B: TGVector2): Boolean;
    class operator GreaterThan(const A, B: TGVector2): Boolean;
    class operator GreaterThanOrEqual(const A, B: TGVector2): Boolean;

    class operator Implicit(const A: TGVector3): TGVector2;
    class operator Implicit(const A: TGVector4): TGVector2;

    class operator Implicit(const A: TGVector2): TGVector3;
    class operator Implicit(const A: TGVector2): TGVector4;

    class operator Implicit(const A: TGVector2): String;

    function ToVec3(const Z: Single = 0): TGVector3;
    function ToVec4(const Z: Single = 0; const W: Single = 1): TGVector4;

    function Cross: TGVector2;  // = Rotate 90
    function Dot(const A: TGVector2): Single;
    function SqrDot: Single;
    function Length: Single;
    function DistanceTo(const A: TGVector2): Single;
    function VectorTo(const A: TGVector2): TGVector2;
    function Normalize: TGVector2;
    function Abs: TGVector2;
    function GetCosAngle(const A: TGVector2): Single;
    function AngleTo(const A: TGVector2): Single;
    function Floor: TGVector2;
    function Ceil: TGVector2;

    function ToString: String;

    function Rotate(Angle: Single): TGVector2;

    constructor Create(const X, Y: Single);

    class function VecXY(const A: TGVector3): TGVector2; static;
    class function VecYX(const A: TGVector3): TGVector2; static;
    class function VecYZ(const A: TGVector3): TGVector2; static;
    class function VecZY(const A: TGVector3): TGVector2; static;
    class function VecZX(const A: TGVector3): TGVector2; static;
    class function VecXZ(const A: TGVector3): TGVector2; static;

    property S: Single read X write X;
    property T: Single read Y write Y;

  end;

  TTrianglePoints = array [TTriangleSide] of TGVector2;

  { TGBounds1 }

  TGBounds1 = record
  private
    function GetMiddle: Single;

    function GetPoint(APoint: Single): Single;

  public
    C1, C2: Single;

    property Low: Single read C1 write C1;
    property High: Single read C2 write C2;

    property Middle: Single read GetMiddle;

    procedure Translate(AAmount: Single);

    function Length: Single;

    property Point[APoint: Single]: Single read GetPoint; default;
    function FindPoint(APoint: Single): Single;

    function EnsureRange(ARange: TGBounds1; out AResult: TGBounds1): Boolean; overload;
    function EnsureRange(AValue: Single): Single; overload;
    function Normalize: TGBounds1;

    class operator in(AValue: Single; ABounds: TGBounds1): Boolean;

    class operator Equal(ABounds1, ABounds2: TGBounds1): Boolean;
    class operator NotEqual(ABounds1, ABounds2: TGBounds1): Boolean;
    class operator GreaterThan(AValue: Single; ABounds: TGBounds1): Boolean;
    class operator GreaterThanOrEqual(AValue: Single; ABounds: TGBounds1): Boolean;
    class operator LessThan(AValue: Single; ABounds: TGBounds1): Boolean;
    class operator LessThanOrEqual(AValue: Single; ABounds: TGBounds1): Boolean;

    class operator Add(ABounds: TGBounds1; AValue: Single): TGBounds1;
    class operator Add(AValue: Single; ABounds: TGBounds1): TGBounds1;
    class operator Subtract(ABounds: TGBounds1; AValue: Single): TGBounds1;
    class operator Subtract(AValue: Single; ABounds: TGBounds1): TGBounds1;

    class operator Multiply(ABounds: TGBounds1; AValue: Single): TGBounds1;
    class operator Divide(ABounds: TGBounds1; AValue: Single): TGBounds1;

    constructor Create(AC1, AC2: Single);
  end;

  { TGBounds2 }

  TGBounds2 = record
  private
    function GetHorizontal: TGBounds1;
    function GetMiddle: TGVector2;
    function GetVertical: TGBounds1;

    procedure SetBottom(AValue: Single);
    procedure SetHorizontal(AValue: TGBounds1);
    procedure SetLeft(AValue: Single);
    procedure SetRight(AValue: Single);
    procedure SetTop(AValue: Single);

    function GetHeight: Single;
    function GetWidth: Single;
    function GetSize: TGVector2;

    function GetArea: Single;

    function GetPoint(APoint: TGVector2): TGVector2;
    procedure SetVertical(AValue: TGBounds1);

  public
    C1, C2: TGVector2;

    property Left: Single read C1.X write SetLeft;
    property Right: Single read C2.X write SetRight;
    property Bottom: Single read C1.Y write SetBottom;
    property Top: Single read C2.Y write SetTop;

    function LeftMid: TGVector2;
    function RightMid: TGVector2;
    function BottomMid: TGVector2;
    function TopMid: TGVector2;

    property Horizontal: TGBounds1 read GetHorizontal write SetHorizontal;
    property Vertical: TGBounds1 read GetVertical write SetVertical;

    property Middle: TGVector2 read GetMiddle;

    procedure Translate(AAmount: TGVector2);

    property Width: Single read GetWidth;
    property Height: Single read GetHeight;
    property Size: TGVector2 read GetSize;

    property Area: Single read GetArea;

    property Point[APoint: TGVector2]: TGVector2 read GetPoint; default;
    function FindPoint(APoint: TGVector2): TGVector2;

    function EnsureRange(ARange: TGBounds2; out AResult: TGBounds2): Boolean;
    function Normalize: TGBounds2;

    class operator In(AVector: TGVector2; ABounds: TGBounds2): Boolean;

    constructor Create(AC1, AC2: TGVector2);
  end;

  { TGBounds3 }

  TGBounds3 = record
  public
    type
      TCorners = array [0 .. 7] of TGVector3;
  private
    function GetDepth: Single;
    function GetHeight: Single;
    function GetWidth: Single;
    function GetSize: TGVector3;

    function GetVolume: Single;

    function GetPoint(APoint: TGVector3): TGVector3;

  public
    C1, C2: TGVector3;

    property Left: Single read C1.X write C1.X;
    property Right: Single read C2.X write C2.X;
    property Bottom: Single read C1.Y write C1.Y;
    property Top: Single read C2.Y write C2.Y;
    property Front: Single read C1.Z write C1.Z;
    property Back: Single read C2.Z write C2.Z;

    procedure Translate(AAmount: TGVector3);

    property Width: Single read GetWidth;
    property Height: Single read GetHeight;
    property Depth: Single read GetDepth;

    property Size: TGVector3 read GetSize;

    property Volume: Single read GetVolume;

    property Point[APoint: TGVector3]: TGVector3 read GetPoint; default;
    function FindPoint(APoint: TGVector3): TGVector3;

    function EnsureRange(ARange: TGBounds3; out AResult: TGBounds3): Boolean;
    function Normalize: TGBounds3;

    function GetCorners: TCorners;

    class operator In(AVector: TGVector3; ABounds: TGBounds3): Boolean;

    constructor Create(AC1, AC2: TGVector3);
  end;

  { TIntBounds1 }

  TIntBounds1 = record
  private
    function GetPoint(APoint: Single): Integer;
  public
    C1, C2: Integer;

    property Low: Integer read C1 write C1;
    property High: Integer read C2 write C2;

    procedure Translate(AAmount: Integer);

    function Length: Integer;

    function EnsureRange(ARange: TIntBounds1; out AResult: TIntBounds1): Boolean; overload;
    function EnsureRange(AValue: Integer): Integer; overload;
    function Normalize: TIntBounds1;

    property Point[APos: Single]: Integer read GetPoint; default;
    function FindPoint(APoint: Integer): Single;

    class operator in(AValue: Integer; ABounds: TIntBounds1): Boolean;

    class operator Equal(ABounds1, ABounds2: TIntBounds1): Boolean;
    class operator NotEqual(ABounds1, ABounds2: TIntBounds1): Boolean;
    class operator GreaterThan(AValue: Integer; ABounds: TIntBounds1): Boolean;
    class operator GreaterThanOrEqual(AValue: Integer; ABounds: TIntBounds1): Boolean;
    class operator LessThan(AValue: Integer; ABounds: TIntBounds1): Boolean;
    class operator LessThanOrEqual(AValue: Integer; ABounds: TIntBounds1): Boolean;


    constructor Create(AC1, AC2: Integer);
  end;

  { TIntBounds2 }

  TIntBounds2 = record
  private

  public

  end;

  TTexCoord2 = TGVector2;
  TTexCoord3 = TGVector3;
  TTexCoord4 = TGVector4;

  { TGDirection }
  // TurnPitch 0 = +UVecZ
  // Turn 90 =     +UVecX
  // Pitch 90 =    +UVecY
  TGDirection = record
  private
    function GetPitchAngle: Single;
    function GetTurnAngle: Single;
    procedure SetPitchAngle(AValue: Single);
    procedure SetTurnAngle(AValue: Single);
  public
    T, P: Single;

    class function FromVector(ADirection: TGVector3): TGDirection; static;

    constructor Create(const T, P: Single);

    function ToVector: TGVector; overload;
    function ToVector(const Scale: Single): TGVector3; overload;
    function ToVector(const Scale: TGVector3): TGVector3; overload;

    function Turn(const Angle: Single): TGDirection;
    function Pitch(const Angle: Single): TGDirection;
    function TurnPitch(const TAngle, PAngle: Single): TGDirection;

    property TurnAngle: Single read GetTurnAngle write SetTurnAngle;
    property PitchAngle: Single read GetPitchAngle write SetPitchAngle;

  end;

  { TGLine }

  TGLine = record
  private
    procedure FillM3x2LineIntsec(const A: TGLine); inline;

  public
    type
      TOrthoProjData = record
        Distance: Single;
        Height: Single;
        Point: TGVector3;
      end;
  public
    SV, DV: TGVector3;

    function GetPoint(Distance: Single): TGVector3;
    function Head: TGVector3; inline;
    function Tail: TGVector3; inline;

    function OrthoProj(const A: TGVector3): Boolean; overload;
    function OrthoProj(const A: TGVector3; out AData: TOrthoProjData): Boolean; overload;
    function OrthoProjDistance(const A: TGVector3): Single; inline;

    function Intsec(const A: TGLine): Boolean; overload;
    function Intsec(const A: TGLine; out S: Single): Boolean; overload;
    function LineIntsec(const A: TGLine; out P: TGVector3): Boolean; overload;

    property Point[Distance: Single]: TGVector3 read GetPoint; default;

    function MirrorVector(AVector: TGVector3): TGVector3;

    constructor Create(const SV, DV: TGVector3);
  end;

  TLineSide = (lsLeft, lsOn, lsRight);

  { TGLine2 }

  TGLine2 = record
  private
    procedure FillM3x2Line2Intsec(const A: TGLine2); inline;
  public
    type
      TOrthoProjData = record
        Distance: Single;
        Height: Single;
        Point: TGVector2;
      end;
  public
    SV, DV: TGVector2;

    function GetPoint(const Distance: Single): TGVector2;
    function Head: TGVector2; inline;
    function Tail: TGVector2; inline;

    function IntsecOrTouch(const A: TGLine2): Boolean;
    function Intsec(const A: TGLine2): Boolean;

    function OrthoProj(const A: TGVector2): Boolean; overload;
    function OrthoProj(const A: TGVector2; out AData: TOrthoProjData): Boolean; overload;

    function AngleTo(const A: TGLine2): Single;
    function EqualTo(const A: TGLine2; AIgnoreDir: Boolean = True): Boolean;

    function GetSlope(out FFlipped: Boolean): Single;

    function PointLocation(A: TGVector2): TLineSide;

    constructor Create(const SV, DV: TGVector);
  end;

  { TGVector2LineHelper }

  TGVector2LineHelper = record helper for TGVector2
    function LineTo(AVector: TGVector2): TGLine2;
  end;

  { TGPlane }

  TGPlane = record
  private
    procedure FillM4x3LineIntsec(const A: TGLine);
    procedure FillM3x2PointIntsec(const A: TGVector);
  public
    type
      TLineIntsecData = record
        Distance: Single;
        PlaneCoord: TGVector2;
        Point: TGVector3;
      end;

      TOrthoProjData = record
        Height: Single;
        PlaneCoord: TGVector2;
        Point: TGVector3;
      end;

      TPointIntsecData = record
        PlaneCoord: TGVector2;
      end;

  public
    SV, DVS, DVT: TGVector3;

    class operator Equal(const A, B: TGPlane): Boolean;

    function PointIntsec(const A: TGVector3; out AData: TPointIntsecData): Boolean;

    function LineIntsec(const A: TGLine): Boolean; overload;
    function LineIntsec(const A: TGLine; out AData: TLineIntsecData): Boolean; overload;

    procedure OrthoProj(const A: TGVector3; out AData: TOrthoProjData);

    function LineInQuad(const A: TGLine; out AData: TLineIntsecData; const ACheckScale: Single = 1): Boolean; overload;
    function LineInTri(const A: TGLine; out AData: TLineIntsecData; const ACheckScale: Single = 1): Boolean; overload;
    function LineInCircle(const A: TGLine; out AData: TLineIntsecData; const ACheckScale: Single = 1): Boolean; overload;

    function LineInQuad(const A: TGLine; const ACheckScale: Single = 1): Boolean; overload; inline;
    function LineInTri(const A: TGLine; const ACheckScale: Single = 1): Boolean; overload; inline;
    function LineInCircle(const A: TGLine; const ACheckScale: Single = 1): Boolean; overload; inline;

    function Normal: TGVector3;

    function AngleTo(const APlane: TGPlane): Single;

    function GetPoint(V: TGVector2): TGVector3; overload;
    function GetPoint(S, T: Single): TGVector3; overload;

    property Point[V: TGVector2]: TGVector3 read GetPoint; default;

    function GetParaPoint: TGVector3; inline;

    function GetAreaTri: Single; inline;
    function GetAreaQuad: Single; inline;

    constructor Create(const SV, DVS, DVT: TGVector3);
  end;

  TLocationChange = (
    lcPosition,
    lcOffset,
    lcScale,
    lcTurn,
    lcPitch,
    lcRoll,
    lcFreeTranslation,
    lcFreeScale,
    lcFreeRotation,
    lcFreeMirror);
  TLocationChanges = set of TLocationChange;

  TChangeProcedure = procedure (AChanges: TLocationChanges) of object;

  { TLocation }

  TLocation = class
  private

    FPos: TGVector3;
    FOffset: TGVector3;
    FScale: TGVector3;
    FPitch: Single;
    FTurn: Single;
    FRoll: Single;

    FMatrix: TMatrix4;
    FInvMatrix: TMatrix4;

    FRotMatrix: TMatrix3;
    FInvRotMatrix: TMatrix3;

    FMatrixChanged: Boolean;
    FInvMatrixChanged: Boolean;
    FRotMatrixChanged: Boolean;
    FInvRotMatrixChanged: Boolean;

    FFreeChanged: Boolean;
    FInverted: Boolean;

    FChanged: Boolean;

    FOnChange: TChangeProcedure;

    procedure SetLook(AValue: TGVector3);
    procedure TriggerChanges(AChanges: TLocationChanges);

    function GetMatrix: TMatrix4;
    function GetInvMatrix: TMatrix4;

    function GetRotMatrix: TMatrix3;
    function GetInvRotMatrix: TMatrix3;

    function GetRealPosition: TGVector3;

    function GetRight: TGVector3;
    function GetLook: TGVector3;
    function GetUp: TGVector3;

    procedure BuildMatrix;

    procedure SetPos(AValue: TGVector3);
    procedure SetPosX(AValue: Single);
    procedure SetPosY(AValue: Single);
    procedure SetPosZ(AValue: Single);

    procedure SetOffset(AValue: TGVector3);
    procedure SetOffsetX(AValue: Single);
    procedure SetOffsetY(AValue: Single);
    procedure SetOffsetZ(AValue: Single);

    procedure SetScale(AValue: TGVector3);
    procedure SetScaleX(AValue: Single);
    procedure SetScaleY(AValue: Single);
    procedure SetScaleZ(AValue: Single);

    procedure SetPitch(AValue: Single);
    procedure SetRoll(AValue: Single);
    procedure SetTurn(AValue: Single);

  public
    constructor Create(AInverted: Boolean = False);

    property Matrix: TMatrix4 read GetMatrix;
    property InvMatrix: TMatrix4 read GetInvMatrix;

    property RotMatrix: TMatrix3 read GetRotMatrix;
    property InvRotMatrix: TMatrix3 read GetInvRotMatrix;

    property Pos: TGVector3 read FPos write SetPos;
    property PosX: Single read FPos.X write SetPosX;
    property PosY: Single read FPos.Y write SetPosY;
    property PosZ: Single read FPos.Z write SetPosZ;

    property Offset: TGVector3 read FOffset write SetOffset;
    property OffsetX: Single read FOffset.X write SetOffsetX;
    property OffsetY: Single read FOffset.Y write SetOffsetY;
    property OffsetZ: Single read FOffset.Z write SetOffsetZ;

    property Scale: TGVector3 read FScale write SetScale;
    property ScaleX: Single read FScale.X write SetScaleX;
    property ScaleY: Single read FScale.Y write SetScaleY;
    property ScaleZ: Single read FScale.Z write SetScaleZ;

    procedure Slide(ADistance: Single; AHorizontal: Boolean = False);
    procedure Lift(ADistance: Single; AYOnly: Boolean = False);
    procedure Move(ADistance: Single; AHorizontal: Boolean = False);

    property TurnAngle: Single read FTurn write SetTurn;
    property PitchAngle: Single read FPitch write SetPitch;
    property RollAngle: Single read FRoll write SetRoll;

    property OnChange: TChangeProcedure write FOnChange;

    property Right: TGVector3 read GetRight;
    property Up: TGVector3 read GetUp;
    property Look: TGVector3 read GetLook write SetLook;

    procedure LookAt(APoint: TGVector3);

    property RealPosition: TGVector3 read GetRealPosition;

    // All of the following functions will trigger the rebuild once the Matrix is requested
    procedure Reset;
    procedure ResetTranslation;
    procedure ResetOffset;
    procedure ResetScale;
    procedure ResetRotation;

    procedure Turn(const ATurn: Single);
    procedure Pitch(const APitch: Single);
    procedure Roll(const ARoll: Single);

    procedure Translate(const AVector: TGVector3);
    procedure MoveOffset(const AVector: TGVector3);
    procedure ScaleBy(const AScale: TGVector3);

    procedure Approach(ALocation: TLocation; ADelta: Single);
    procedure Assign(ALocation: TLocation);
    procedure Swap(ALocation: TLocation);

    property Changed: Boolean read FChanged;
    procedure NotifyChanges;

    // Those will directly change the current Matrix and thus not trigger the rebuild
    // FTurn/FPitch/FRoll/FPos/FOffset won't be correct anymore
    procedure FreeRotate(AVector: TGVector3; const AAngle: Single);
    procedure FreeTurn(ATurn: Single);
    procedure FreePitch(APitch: Single);
    procedure FreeRoll(ARoll: Single);
    procedure FreeTranslate(const AVector: TGVector3);
    procedure FreeScale(const AScale: TGVector3);

    procedure FreeMirror(ANormal: TGLine);

    procedure FromMatrix(AMatrix: TMatrix4);
    procedure FromRotMatrix(AMatrix: TMatrix3);

  end;

  { TGEllipse }

  TGEllipse = record
  private
    FDVS, FDVT: TGVector;
    procedure SetDVS(const Value: TGVector);
    procedure SetDVT(const Value: TGVector);
  public
    SV: TGVector;
    property DVS: TGVector read FDVS write SetDVS;
    property DVT: TGVector read FDVT write SetDVT;

    function GetPoint(S: Single): TGVector;

    class function NewS(SV, DVS, DVT: TGVector): TGEllipse; static;
    class function NewT(SV, DVS, DVT: TGVector): TGEllipse; static;
  end;

  { TSphere }

  TSphere = class
  public
    type

      { TLineIntsecPointData }

      TLineIntsecPointData = record
        Point: TGVector3;
        Distance: Single;
        Direction: TGDirection;
      end;

      { TLineIntsecData }
      // Note: NearData and FarData are defined as NearData.Distance < FarData.Distance (Distance = DV factor of line)
      TLineIntsecData = record
        NearData, FarData: TLineIntsecPointData;
        Height: Single;
      end;

  private
    FLocation: TLocation;
    FScale: TGVector3;

  public
    constructor Create; overload;
    constructor Create(AScale: TGVector3); overload;
    destructor Destroy; override;

    function LineIntsec(ALine: TGLine): Boolean; overload;
    function LineIntsec(ALine: TGLine; out AData: TLineIntsecData): Boolean; overload;

    function GetPoint(const D: TGDirection; const AScale: Single = 1): TGVector3; overload;

    property Location: TLocation read FLocation;
    property Scale: TGVector3 read FScale write FScale;
    property ScaleX: Single read FScale.X write FScale.X;
    property ScaleY: Single read FScale.Y write FScale.Y;
    property ScaleZ: Single read FScale.Z write FScale.Z;
  end;

  { TBlockRotation }

  TBlockRotation = class
  private
    // positive directions
    FX, FY, FZ: TGBasicDir3;

    FChanged: Boolean;
  public
    constructor Create; overload;
    constructor Create(AX, AY, AZ: TGBasicDir3); overload;

    property X: TGBasicDir3 read FX;
    property Y: TGBasicDir3 read FY;
    property Z: TGBasicDir3 read FZ;

    function Convert(ADirection: TGBasicDir3): TGBasicDir3;
    function ConvertBack(ADirection: TGBasicDir3): TGBasicDir3;

    function Matrix: TMatrix3;
    procedure FromMatrix(AMatrix: TMatrix3);

    procedure Rotate(AAxis: TGBasicDir3; ASteps: Integer = 1);
    procedure Mirror(ANormal: TGBasicDir3);
    procedure Invert;

    procedure Reset;

    function Equal(ABlockRotation: TBlockRotation): Boolean;

    procedure Assign(ABlockRotation: TBlockRotation);

    function Changed: Boolean;
    procedure NotifyChanges;

  end;

  { EBlockDirectionError }

  EBlockDirectionError = class (Exception)
  public
    constructor Create;
  end;

  { TIntVector }

  TIntVector = record
    X, Y, Z: Integer;

    class operator Add(const A, B: TIntVector): TIntVector;
    class operator Subtract(const A, B: TIntVector): TIntVector;

    class operator Add(const A: TIntVector; B: Integer): TIntVector;
    class operator Subtract(const A: TIntVector; B: Integer): TIntVector;

    class operator Multiply(const A: TIntVector; B: Integer): TIntVector;
    class operator Multiply(A: Integer; const B: TIntVector): TIntVector;
    class operator IntDivide(const A: TIntVector; B: Integer): TIntVector;
    class operator IntDivide(A: Integer; const B: TIntVector): TIntVector;

    class operator Positive(const A: TIntVector): TIntVector;
    class operator Negative(const A: TIntVector): TIntVector;

    class operator Equal(const A, B: TIntVector): Boolean;
    class operator NotEqual(const A, B: TIntVector): Boolean;
    class operator LessThan(const A, B: TIntVector): Boolean;
    class operator LessThanOrEqual(const A, B: TIntVector): Boolean;
    class operator GreaterThan(const A, B: TIntVector): Boolean;
    class operator GreaterThanOrEqual(const A, B: TIntVector): Boolean;

    class operator Equal(const A: TIntVector; B: Integer): Boolean;
    class operator NotEqual(const A: TIntVector; B: Integer): Boolean;
    class operator LessThan(const A: TIntVector; B: Integer): Boolean;
    class operator LessThanOrEqual(const A: TIntVector; B: Integer): Boolean;
    class operator GreaterThan(const A: TIntVector; B: Integer): Boolean;
    class operator GreaterThanOrEqual(const A: TIntVector; B: Integer): Boolean;

    class operator Implicit(const A: TIntVector): TGVector3;
    class operator Implicit(const A: TIntVector): String;

    function ToString: String;

    class function Floor(const AVector: TGVector3): TIntVector; static;
    class function Ceil(const AVector: TGVector3): TIntVector; static;

    constructor Create(AX, AY, AZ: Integer);
  end;

  { TBlockRaycaster }

  TBlockRaycaster = class
  private
    FLocation: TLocation;
    FSize: TIntVector;

    FLine: TGLine;
    FDirections: TGBasicDirs3;
    FMin, FMax: Single;

    FCurrent: TIntVector;
    FLastDirection: TGBasicDir3;
    FPosition: TGVector3;
  public
    constructor Create(ALocation: TLocation; ASize: TIntVector);

    procedure AddMin(AMin: Single);
    procedure AddMax(AMax: Single);

    procedure Start(ALine: TGLine);
    function Next: Boolean;

    property Current: TIntVector read FCurrent;
    property LastDirection: TGBasicDir3 read FLastDirection;
    property Position: TGVector3 read FPosition;

  end;

  TPointTestResult = (ptInside, ptBorder, ptOutside);

  { TTriangle }

  TTriangle = record
  private
    FPoints: TTrianglePoints;
    function GetLine(AIndex: TTriangleSide): TGLine2;
    function GetPoint(AIndex: TTriangleSide): TGVector2;
    procedure SetPoint(AIndex: TTriangleSide; AValue: TGVector2);
  public
    constructor Create(APoints: TTrianglePoints);

    property Points[AIndex: TTriangleSide]: TGVector2 read GetPoint write SetPoint; default;
    property Lines[AIndex: TTriangleSide]: TGLine2 read GetLine;

    function TestPoint(APoint: TGVector2): TPointTestResult;
  end;

  { TUniquePointList2 }

  TUniquePointList2 = class
  private
    type

      { TIterator }

      TIterator = class
      private
        FBorder: TUniquePointList2;
        FCurrent: Integer;
        function GetCurrent: TGVector2;
      public
        constructor Create(ABorder: TUniquePointList2);
        property Current: TGVector2 read GetCurrent;
        function MoveNext: Boolean;
      end;

  private
    FPoints: array of TGVector2;
    function GetPoint(AIndex: Cardinal): TGVector2;
    function GetPointCount: Integer;

  public
    procedure Add(APoint: TGVector2);
    property Point[AIndex: Cardinal]: TGVector2 read GetPoint; default;
    property PointCount: Integer read GetPointCount;

    function GetEnumerator: TIterator;
  end;

  { TTrianglePlane }

  TTrianglePlane = class
  private
    FTriangles: array of TTriangle;
    FBorderPoints: TUniquePointList2;
    FBorderLines: array of TGLine2;

    FBorderGenerated: Boolean;

    procedure GenerateBorder;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddTriangle(ATriangle: TTriangle);

    function Surrounds(AOther: TTrianglePlane): Boolean;
  end;

  { TGHexahedron }

  TGHexahedron = record
  public
    Faces: array [sdRight .. sdBack] of TGLine;

    function AllOutside(APoints: array of TGVector3): Boolean;

    class operator in(AValue: TGVector3; AHexahedron: TGHexahedron): Boolean;
  end;

  // Pointer
  PGVector = ^TGVector;
  PGVector4 = ^TGVector4;
  PGVector3 = ^TGVector3;
  PGVector2 = ^TGVector2;

  PGDirection = ^TGDirection;
  PGLine = ^TGLine;
  PGPlane = ^TGPlane;
  PGEllipse = ^TGEllipse;
  PGSphere = ^TSphere;

  TGVectors2 = array of TGVector2;
  TGVectors3 = array of TGVector3;
  TGVectors4 = array of TGVector4;
  TGVectors = TGVectors4;
  TGLines = array of TGLine;
  TGPlanes = array of TGPlane;

const
  Origin:  TGVector3 = (X: 0; Y: 0; Z: 0);
  UVecX:   TGVector3 = (X: 1; Y: 0; Z: 0);
  UVecY:   TGVector3 = (X: 0; Y: 1; Z: 0);
  UVecZ:   TGVector3 = (X: 0; Y: 0; Z: 1);
  UVecXY:  TGVector3 = (X: 1; Y: 1; Z: 0);
  UVecYZ:  TGVector3 = (X: 0; Y: 1; Z: 1);
  UVecXZ:  TGVector3 = (X: 1; Y: 0; Z: 1);
  UVecXYZ: TGVector3 = (X: 1; Y: 1; Z: 1);

  InfVec: TGVector3 = (X: Infinity; Y: Infinity; Z: Infinity);
  NaNVec:  TGVector3 = (X: NaN; Y: NaN; Z: NaN);

  VecDir: array [TGBasicDir] of TIntVector = (
    (X:  0; Y:  0; Z:  0),
    (X: +1; Y:  0; Z:  0),
    (X: -1; Y:  0; Z:  0),
    (X:  0; Y: +1; Z:  0),
    (X:  0; Y: -1; Z:  0),
    (X:  0; Y:  0; Z: +1),
    (X:  0; Y:  0; Z: -1));

  QuadSideCount = High(TQuadSide) + 1;

  QuadTexCoords: array [TQuadSide] of TTexCoord2 = (
    (X: 0; Y: 0),
    (X: 1; Y: 0),
    (X: 1; Y: 1),
    (X: 1; Y: 1),
    (X: 0; Y: 1),
    (X: 0; Y: 0)
  );
  QuadMiddleCoords: array [TQuadSide] of TTexCoord2 = (
    (X: -1; Y: -1),
    (X: +1; Y: -1),
    (X: +1; Y: +1),
    (X: +1; Y: +1),
    (X: -1; Y: +1),
    (X: -1; Y: -1)
  );
  TriangleTexCoords: array [TTriangleSide] of TTexCoord2 = (
    (X: 0; Y: 0),
    (X: 1; Y: 0),
    (X: 0; Y: 1)
  );

  BasicDirNames: array [TGBasicDir] of String = (
    'none',
    'right',
    'left',
    'up',
    'down',
    'front',
    'back'
  );

  CubePlanes: array [TGBasicDir3] of TGPlane = (
    (SV: (X: 1; Y: 0; Z: 0); DVS: (X: 0; Y: 1; Z: 0); DVT: (X: 0; Y: 0; Z: 1)), // right
    (SV: (X: 0; Y: 0; Z: 0); DVS: (X: 0; Y: 1; Z: 0); DVT: (X: 0; Y: 0; Z: 1)), // left
    (SV: (X: 0; Y: 1; Z: 0); DVS: (X: 1; Y: 0; Z: 0); DVT: (X: 0; Y: 0; Z: 1)), // up
    (SV: (X: 0; Y: 0; Z: 0); DVS: (X: 1; Y: 0; Z: 0); DVT: (X: 0; Y: 0; Z: 1)), // down
    (SV: (X: 0; Y: 0; Z: 1); DVS: (X: 1; Y: 0; Z: 0); DVT: (X: 0; Y: 1; Z: 0)), // front
    (SV: (X: 0; Y: 0; Z: 0); DVS: (X: 1; Y: 0; Z: 0); DVT: (X: 0; Y: 1; Z: 0))  // back
  );

function InvertBasicDir(ADir: TGBasicDir): TGBasicDir;
function AbsBasicDir(ADir: TGBasicDir): TGBasicDir;
function RotateBasicDir(ADir: TGBasicDir; AAxis: TGBasicDir3; ASteps: Integer = 1): TGBasicDir;
function DirectionsFromVector(AVector: TGVector3): TGBasicDirs3;

implementation

const
  MinRotation = -180;
  MaxRotation = 180;

function InvertBasicDir(ADir: TGBasicDir): TGBasicDir;
begin
  Result := sdNone;
  case ADir of
  sdRight:
    Exit(sdLeft);
  sdLeft:
    Exit(sdRight);
  sdUp:
    Exit(sdDown);
  sdDown:
    Exit(sdUp);
  sdFront:
    Exit(sdBack);
  sdBack:
    Exit(sdFront);
  end;
end;

function AbsBasicDir(ADir: TGBasicDir): TGBasicDir;
begin
  case ADir of
  sdLeft:
    Exit(sdRight);
  sdDown:
    Exit(sdUp);
  sdBack:
    Exit(sdFront);
  else
    Exit(ADir);
  end;
end;

function RotateBasicDir(ADir: TGBasicDir; AAxis: TGBasicDir3; ASteps: Integer): TGBasicDir;
begin
  Result := sdNone;

  if (AbsBasicDir(ADir) = AbsBasicDir(AAxis)) or (ADir = sdNone) then
    Exit(ADir);
  if ASteps < 0 then
    ASteps := ASteps - Floor(ASteps / 4) * 4;
  case ASteps mod 4 of
    0:
      Exit(ADir);
    2:
      Exit(InvertBasicDir(ADir));
    1: // CW if axis points toward eye
    begin
      case AAxis of
      sdRight:
        case ADir of
          sdUp:     Exit(sdBack);
          sdDown:   Exit(sdFront);
          sdFront:  Exit(sdUp);
          sdBack:   Exit(sdDown);
        end;
      sdLeft:
        case ADir of
          sdUp:     Exit(sdFront);
          sdDown:   Exit(sdBack);
          sdFront:  Exit(sdDown);
          sdBack:   Exit(sdUp);
        end;
      sdUp:
        case ADir of
          sdRight:  Exit(sdFront);
          sdLeft:   Exit(sdBack);
          sdFront:  Exit(sdLeft);
          sdBack:   Exit(sdRight);
        end;
      sdDown:
        case ADir of
          sdRight:  Exit(sdBack);
          sdLeft:   Exit(sdFront);
          sdFront:  Exit(sdRight);
          sdBack:   Exit(sdLeft);
        end;
      sdFront:
        case ADir of
          sdRight:  Exit(sdDown);
          sdLeft:   Exit(sdUp);
          sdUp:     Exit(sdRight);
          sdDown:   Exit(sdLeft);
        end;
      sdBack:
        case ADir of
          sdRight:  Exit(sdUp);
          sdLeft:   Exit(sdDown);
          sdUp:     Exit(sdLeft);
          sdDown:   Exit(sdRight);
        end;
      end;
    end;
    3: // CCW
    begin
      case AAxis of
      sdRight:
        case ADir of
          sdUp:     Exit(sdFront);
          sdDown:   Exit(sdBack);
          sdFront:  Exit(sdDown);
          sdBack:   Exit(sdUp);
        end;
      sdLeft:
        case ADir of
          sdUp:     Exit(sdBack);
          sdDown:   Exit(sdFront);
          sdFront:  Exit(sdUp);
          sdBack:   Exit(sdDown);
        end;
      sdUp:
        case ADir of
          sdRight:  Exit(sdBack);
          sdLeft:   Exit(sdFront);
          sdFront:  Exit(sdRight);
          sdBack:   Exit(sdLeft);
        end;
      sdDown:
        case ADir of
          sdRight:  Exit(sdFront);
          sdLeft:   Exit(sdBack);
          sdFront:  Exit(sdLeft);
          sdBack:   Exit(sdRight);
        end;
      sdFront:
        case ADir of
          sdRight:  Exit(sdUp);
          sdLeft:   Exit(sdDown);
          sdUp:     Exit(sdLeft);
          sdDown:   Exit(sdRight);
        end;
      sdBack:
        case ADir of
          sdRight:  Exit(sdDown);
          sdLeft:   Exit(sdUp);
          sdUp:     Exit(sdRight);
          sdDown:   Exit(sdLeft);
        end;
      end;
    end;
  end;
end;

function DirectionsFromVector(AVector: TGVector3): TGBasicDirs3;
begin
  Result := [];
  if AVector.X > 0 then
    Include(Result, sdRight);
  if AVector.X < 0 then
    Include(Result, sdLeft);
  if AVector.Y > 0 then
    Include(Result, sdUp);
  if AVector.Y < 0 then
    Include(Result, sdDown);
  if AVector.Z > 0 then
    Include(Result, sdFront);
  if AVector.Z < 0 then
    Include(Result, sdBack);
end;

{ TGHexahedron }

function TGHexahedron.AllOutside(APoints: array of TGVector3): Boolean;
var
  F: TGLine;
  P: TGVector3;
  AllPointsOutside: Boolean;
begin
  for F in Faces do
  begin
    AllPointsOutside := True;
    for P in APoints do
    begin
      if F.DV.Dot(F.SV.VectorTo(P)) > 0 then
      begin
        AllPointsOutside := False;
        Break;
      end;
    end;
    if AllPointsOutside then
      Exit(True);
  end;
  Result := False;
end;

class operator TGHexahedron.in(AValue: TGVector3; AHexahedron: TGHexahedron): Boolean;
var
  S: TGBasicDir3;
begin
  for S := Low(TGBasicDir3) to High(TGBasicDir3) do
    if AHexahedron.Faces[S].DV.Dot(AHexahedron.Faces[S].SV.VectorTo(AValue)) < 0 then
      Exit(False);
  Result := True;
end;

{ TGBounds3 }

function TGBounds3.GetDepth: Single;
begin
  Result := C2.Z - C1.Z;
end;

function TGBounds3.GetHeight: Single;
begin
  Result := C2.Y - C1.Y;
end;

function TGBounds3.GetWidth: Single;
begin
  Result := C2.X - C1.X;
end;


function TGBounds3.GetSize: TGVector3;
begin
  Result := C2 - C1;
end;

function TGBounds3.GetVolume: Single;
begin
  Result := Width * Height * Depth;
end;

function TGBounds3.GetPoint(APoint: TGVector3): TGVector3;
begin
  Result := C1 + Size * APoint;
end;

procedure TGBounds3.Translate(AAmount: TGVector3);
begin
  C1 := C1 + AAmount;
  C2 := C2 + AAmount;
end;

function TGBounds3.FindPoint(APoint: TGVector3): TGVector3;
begin
  Result := (APoint - C1) / Size;
end;

function TGBounds3.EnsureRange(ARange: TGBounds3; out AResult: TGBounds3): Boolean;
begin
  AResult.Left := Max(Left, ARange.Left);
  AResult.Right := Min(Right, ARange.Right);
  AResult.Bottom := Max(Bottom, ARange.Bottom);
  AResult.Top := Min(Top, ARange.Top);
  AResult.Front := Max(Top, ARange.Front);
  AResult.Back := Min(Back, ARange.Back);
  Result := (AResult.Width >= 0) and (AResult.Height >= 0) and (AResult.Depth >= 0);
end;

function TGBounds3.Normalize: TGBounds3;
begin
  if Width < 0 then
  begin
    Result.Left := Right;
    Result.Right := Left;
  end
  else
  begin
    Result.Left := Left;
    Result.Right := Right;
  end;
  if Height < 0 then
  begin
    Result.Bottom := Top;
    Result.Top := Bottom;
  end
  else
  begin
    Result.Bottom := Bottom;
    Result.Top := Top;
  end;
  if Depth < 0 then
  begin
    Result.Back := Front;
    Result.Front := Back;
  end
  else
  begin
    Result.Back := Back;
    Result.Front := Front;
  end;
end;

function TGBounds3.GetCorners: TCorners;
begin
  Result[0] := TGVector3.Create(C1.X, C1.Y, C1.Z);
  Result[1] := TGVector3.Create(C1.X, C1.Y, C2.Z);
  Result[2] := TGVector3.Create(C1.X, C2.Y, C1.Z);
  Result[3] := TGVector3.Create(C1.X, C2.Y, C2.Z);
  Result[4] := TGVector3.Create(C2.X, C1.Y, C1.Z);
  Result[5] := TGVector3.Create(C2.X, C1.Y, C2.Z);
  Result[6] := TGVector3.Create(C2.X, C2.Y, C1.Z);
  Result[7] := TGVector3.Create(C2.X, C2.Y, C2.Z);
end;

class operator TGBounds3.in(AVector: TGVector3; ABounds: TGBounds3): Boolean;
begin
  Result := (AVector >= ABounds.C1) and (AVector <= ABounds.C2);
end;

constructor TGBounds3.Create(AC1, AC2: TGVector3);
begin
  C1 := AC1;
  C2 := AC2;
end;

{ TIntBounds1 }

function TIntBounds1.GetPoint(APoint: Single): Integer;
begin
  Result := Floor(C1 + Length * APoint + 0.5);
end;

procedure TIntBounds1.Translate(AAmount: Integer);
begin
  C1 := C1 + AAmount;
  C2 := C2 + AAmount;
end;

function TIntBounds1.Length: Integer;
begin
  Result := C2 - C1;
end;

function TIntBounds1.EnsureRange(ARange: TIntBounds1; out AResult: TIntBounds1): Boolean;
begin
  AResult.Low := Max(Low, ARange.Low);
  AResult.High := Min(High, ARange.High);
  Result := AResult.Length >= 0;
end;

function TIntBounds1.EnsureRange(AValue: Integer): Integer;
begin
  Result := Math.EnsureRange(AValue, Low, High);
end;

function TIntBounds1.Normalize: TIntBounds1;
begin
  if Length >= 0 then
  begin
    Result.C1 := C2;
    Result.C2 := C1;
  end
  else
    Result := Self;
end;

function TIntBounds1.FindPoint(APoint: Integer): Single;
begin
  Result := (APoint - C1) / Length;
end;

class operator TIntBounds1.in(AValue: Integer; ABounds: TIntBounds1): Boolean;
begin
  Result := (AValue >= ABounds.Low) and (AValue <= ABounds.High);
end;

class operator TIntBounds1.Equal(ABounds1, ABounds2: TIntBounds1): Boolean;
begin
  Result := (ABounds1.C1 = ABounds2.C1) and (ABounds1.C2 = ABounds2.C2);
end;

class operator TIntBounds1.NotEqual(ABounds1, ABounds2: TIntBounds1): Boolean;
begin
  Result := (ABounds1.C1 <> ABounds2.C1) or (ABounds1.C2 <> ABounds2.C2);
end;

class operator TIntBounds1.GreaterThan(AValue: Integer; ABounds: TIntBounds1): Boolean;
begin
  Result := AValue > ABounds.High;
end;

class operator TIntBounds1.GreaterThanOrEqual(AValue: Integer; ABounds: TIntBounds1): Boolean;
begin
  Result := AValue >= ABounds.High;
end;

class operator TIntBounds1.LessThan(AValue: Integer; ABounds: TIntBounds1): Boolean;
begin
  Result := AValue < ABounds.Low;
end;

class operator TIntBounds1.LessThanOrEqual(AValue: Integer; ABounds: TIntBounds1): Boolean;
begin
  Result := AValue <= ABounds.Low;
end;

constructor TIntBounds1.Create(AC1, AC2: Integer);
begin
  C1 := AC1;
  C2 := AC2;
end;

{ TGBounds1 }

function TGBounds1.GetMiddle: Single;
begin
  Result := (C1 + C2) / 2;
end;

function TGBounds1.Length: Single;
begin
  Result := C2 - C1;
end;

function TGBounds1.GetPoint(APoint: Single): Single;
begin
  Result := C1 + Length * APoint;
end;

procedure TGBounds1.Translate(AAmount: Single);
begin
  C1 := C1 + AAmount;
  C2 := C2 + AAmount;
end;

function TGBounds1.FindPoint(APoint: Single): Single;
begin
  Result := APoint / (C1 + Length);
end;

function TGBounds1.EnsureRange(ARange: TGBounds1; out AResult: TGBounds1): Boolean;
begin
  AResult.Low := Max(Low, ARange.Low);
  AResult.High := Min(High, ARange.High);
  Result := AResult.Length >= 0;
end;

function TGBounds1.EnsureRange(AValue: Single): Single;
begin
  Result := Math.EnsureRange(AValue, Low, High);
end;

function TGBounds1.Normalize: TGBounds1;
begin
  if Length < 0 then
  begin
    Result.Low := High;
    Result.High := Low;
  end
  else
    Result := Self;
end;

class operator TGBounds1.in(AValue: Single; ABounds: TGBounds1): Boolean;
begin
  Result := (AValue >= ABounds.C1) and (AValue <= ABounds.C2);
end;

class operator TGBounds1.Equal(ABounds1, ABounds2: TGBounds1): Boolean;
begin
  Result := (ABounds1.C1 = ABounds2.C1) and (ABounds1.C2 = ABounds2.C2);
end;

class operator TGBounds1.NotEqual(ABounds1, ABounds2: TGBounds1): Boolean;
begin
  Result := (ABounds1.C1 <> ABounds2.C1) or (ABounds1.C2 <> ABounds2.C2);
end;

class operator TGBounds1.GreaterThan(AValue: Single; ABounds: TGBounds1): Boolean;
begin
  Result := AValue > ABounds.High;
end;

class operator TGBounds1.GreaterThanOrEqual(AValue: Single; ABounds: TGBounds1): Boolean;
begin
  Result := AValue >= ABounds.High;
end;

class operator TGBounds1.LessThan(AValue: Single; ABounds: TGBounds1): Boolean;
begin
  Result := AValue < ABounds.Low;
end;

class operator TGBounds1.LessThanOrEqual(AValue: Single; ABounds: TGBounds1): Boolean;
begin
  Result := AValue <= ABounds.Low;
end;

class operator TGBounds1.Add(ABounds: TGBounds1; AValue: Single): TGBounds1;
begin
  Result.C1 := ABounds.C1 + AValue;
  Result.C2 := ABounds.C2 + AValue;
end;

class operator TGBounds1.Add(AValue: Single; ABounds: TGBounds1): TGBounds1;
begin
  Result.C1 := AValue + ABounds.C1;
  Result.C2 := AValue + ABounds.C2;
end;

class operator TGBounds1.Subtract(ABounds: TGBounds1; AValue: Single): TGBounds1;
begin
  Result.C1 := ABounds.C1 - AValue;
  Result.C2 := ABounds.C2 - AValue;
end;

class operator TGBounds1.Subtract(AValue: Single; ABounds: TGBounds1): TGBounds1;
begin
  Result.C1 := AValue - ABounds.C1;
  Result.C2 := AValue - ABounds.C2;
end;

class operator TGBounds1.Multiply(ABounds: TGBounds1; AValue: Single): TGBounds1;
begin
  Result.C1 := ABounds.C1 * AValue;
  Result.C2 := ABounds.C2 * AValue;
end;

class operator TGBounds1.Divide(ABounds: TGBounds1; AValue: Single): TGBounds1;
begin
  Result := ABounds * (1 / AValue);
end;

constructor TGBounds1.Create(AC1, AC2: Single);
begin
  C1 := AC1;
  C2 := AC2;
end;

{ TGBounds2 }

function TGBounds2.GetHeight: Single;
begin
  Result := C2.Y - C1.Y;
end;

function TGBounds2.GetWidth: Single;
begin
  Result := C2.X - C1.X;
end;

function TGBounds2.GetArea: Single;
begin
  Result := Width * Height;
end;

class operator TGBounds2.in(AVector: TGVector2; ABounds: TGBounds2): Boolean;
begin
  Result := (AVector >= ABounds.C1) and (AVector <= ABounds.C2);
end;

function TGBounds2.GetPoint(APoint: TGVector2): TGVector2;
begin
  Result := C1 + Size * APoint;
end;

procedure TGBounds2.SetVertical(AValue: TGBounds1);
begin
  C1.Y := AValue.C1;
  C2.Y := AValue.C2;
end;

function TGBounds2.LeftMid: TGVector2;
begin
  Result.X := Left;
  Result.Y := Vertical.Middle;
end;

function TGBounds2.RightMid: TGVector2;
begin
  Result.X := Right;
  Result.Y := Vertical.Middle;
end;

function TGBounds2.BottomMid: TGVector2;
begin
  Result.X := Horizontal.Middle;
  Result.Y := Bottom;
end;

function TGBounds2.TopMid: TGVector2;
begin
  Result.X := Horizontal.Middle;
  Result.Y := Top;
end;

procedure TGBounds2.Translate(AAmount: TGVector2);
begin
  C1 := C1 + AAmount;
  C2 := C2 + AAmount;
end;

function TGBounds2.FindPoint(APoint: TGVector2): TGVector2;
begin
  Result := (APoint - C1) / Size;
end;

function TGBounds2.EnsureRange(ARange: TGBounds2; out AResult: TGBounds2): Boolean;
begin
  AResult.Left := Max(Left, ARange.Left);
  AResult.Right := Min(Right, ARange.Right);
  AResult.Bottom := Max(Bottom, ARange.Bottom);
  AResult.Top := Min(Top, ARange.Top);
  Result := (AResult.Width >= 0) and (AResult.Height >= 0);
end;

function TGBounds2.Normalize: TGBounds2;
begin
  if Width < 0 then
  begin
    Result.Left := Right;
    Result.Right := Left;
  end
  else
  begin
    Result.Left := Left;
    Result.Right := Right;
  end;
  if Height < 0 then
  begin
    Result.Bottom := Top;
    Result.Top := Bottom;
  end
  else
  begin
    Result.Bottom := Bottom;
    Result.Top := Top;
  end;
end;

function TGBounds2.GetSize: TGVector2;
begin
  Result.X := Width;
  Result.Y := Height;
end;

function TGBounds2.GetHorizontal: TGBounds1;
begin
  Result.C1 := C1.X;
  Result.C2 := C2.X;
end;

function TGBounds2.GetMiddle: TGVector2;
begin
  Result := (C1 + C2) / 2;
end;

function TGBounds2.GetVertical: TGBounds1;
begin
  Result.C1 := C1.Y;
  Result.C2 := C2.Y;
end;

procedure TGBounds2.SetBottom(AValue: Single);
begin
  C1.Y := AValue;
end;

procedure TGBounds2.SetHorizontal(AValue: TGBounds1);
begin
  C1.X := AValue.C1;
  C2.X := AValue.C2;
end;

procedure TGBounds2.SetLeft(AValue: Single);
begin
  C1.X := AValue;
end;

procedure TGBounds2.SetRight(AValue: Single);
begin
  C2.X := AValue;
end;

procedure TGBounds2.SetTop(AValue: Single);
begin
  C2.Y := AValue;
end;

constructor TGBounds2.Create(AC1, AC2: TGVector2);
begin
  C1 := AC1;
  C2 := AC2;
end;

{ TBlockRaycaster }

constructor TBlockRaycaster.Create(ALocation: TLocation; ASize: TIntVector);
begin
  FLocation := ALocation;
  FSize := ASize;
  FMin := -Infinity;
  FMax := +Infinity;
end;

procedure TBlockRaycaster.AddMin(AMin: Single);
begin
  FMin := Max(FMin, AMin);
end;

procedure TBlockRaycaster.AddMax(AMax: Single);
begin
  FMax := Min(FMax, AMax);
end;

procedure TBlockRaycaster.Start(ALine: TGLine);
var
  InvDirections: TGBasicDirs3;
  D: TGBasicDir;
  NormalizedLine: TGLine;
  Data: TGPlane.TLineIntsecData;
  FoundEnd: Boolean;
begin
  FLine.SV := FLocation.InvMatrix * ALine.SV.ToVec4;
  FLine.DV := FLocation.InvRotMatrix * ALine.DV;

  FDirections := DirectionsFromVector(FLine.DV);
  InvDirections := DirectionsFromVector(-FLine.DV);

  NormalizedLine.SV := FLine.SV / FSize;
  NormalizedLine.DV := FLine.DV / FSize;

  FoundEnd := False;
  for D in FDirections do // Find Furthest
    if CubePlanes[D].LineInQuad(NormalizedLine, Data) then
    begin
      FoundEnd := True;
      FMax := Min(Data.Distance, FMax);
      Break;
    end;

  if not FoundEnd then
  begin
    FMin := FMax; // make "Next" return False
  end;

  for D in InvDirections do // Find Closest
    if CubePlanes[D].LineInQuad(NormalizedLine, Data) and
       (Data.Distance > FMin) then
    begin
      FMin := Data.Distance;
      Break;
    end;

  FCurrent := TIntVector.Floor(FLine[FMin]);
  FCurrent.X := EnsureRange(FCurrent.X, 0, FSize.X - 1);
  FCurrent.Y := EnsureRange(FCurrent.Y, 0, FSize.Y - 1);
  FCurrent.Z := EnsureRange(FCurrent.Z, 0, FSize.Z - 1);
end;

function TBlockRaycaster.Next: Boolean;
var
  P: TGPlane;
  Dir: TGBasicDir3;
  Data: TGPlane.TLineIntsecData;
  ClosestDistance: Single;
begin
  if FMin >= FMax then
    Exit(False);

  // Get new Closest FMin for CubePlanes
  ClosestDistance := Infinity;
  for Dir in FDirections do
  begin
    P := CubePlanes[Dir];
    P.SV := P.SV + FCurrent;
    if P.LineIntsec(FLine, Data) and (Data.Distance < ClosestDistance) then
    begin
      ClosestDistance := Data.Distance;
      FLastDirection := Dir;
      FPosition := Data.Point;
    end;
  end;

  FMin := ClosestDistance;

  // Set Current to next block
  FCurrent := FCurrent + VecDir[FLastDirection];

  Result := True;
end;

{ TUniquePointList2.TIterator }

function TUniquePointList2.TIterator.GetCurrent: TGVector2;
begin
  Result := FBorder[FCurrent];
end;

constructor TUniquePointList2.TIterator.Create(ABorder: TUniquePointList2);
begin
  FBorder := ABorder;
  FCurrent := -1;
end;

function TUniquePointList2.TIterator.MoveNext: Boolean;
begin
  Inc(FCurrent);
  Result := FCurrent <> FBorder.PointCount;
end;

{ TUniquePointList2 }

function TUniquePointList2.GetPoint(AIndex: Cardinal): TGVector2;
begin
  Result := FPoints[AIndex];
end;

function TUniquePointList2.GetPointCount: Integer;
begin
  Result := Length(FPoints);
end;

procedure TUniquePointList2.Add(APoint: TGVector2);
var
  P: TGVector2;
begin
  for P in Self do
    if APoint = P then
      Exit;
  SetLength(FPoints, PointCount + 1);
  FPoints[PointCount - 1] := APoint;
end;

function TUniquePointList2.GetEnumerator: TIterator;
begin
  Result := TIterator.Create(Self);
end;

{ TTrianglePlane }

procedure TTrianglePlane.GenerateBorder;
{
var
  MustRemove: TBitField;
  T: TTriangle;
  I, N, J: Integer;
  L: TGLine2;
  HeadData, TailData: TGLine2.TOrthoProjData;
  L1, L2: ^TGLine2;
  }
begin
  {
  if FBorderGenerated then
    Exit;

  // Generate all FBorderLines
  SetLength(FBorderLines, Length(FTriangles) * 3);
  N := 0;
  for T in FTriangles do
    for I := Low(TTriangleSide) to High(TTriangleSide) do
    begin
      FBorderLines[N] := T.Lines[I];
      Inc(N);
    end;

  // Note duplicates for removal
  MustRemove := TBitField.Create(N);
  for I := 0 to N - 1 do
    for J := I + 1 to N - 1 do
      if FBorderLines[I].EqualTo(FBorderLines[J]) then
      begin
        // completely equal > remove full
        MustRemove.Toggle(I);
        MustRemove.Toggle(J);
      end
      else if FBorderLines[I].DV.Normalize.Abs = FBorderLines[J].DV.Normalize.Abs then
      begin
        // if remove parts/split
        // 1) are they ontop of each other?
        if FBorderLines[I].PointLocation(FBorderLines[I].SV) = lsOn then
        begin
          L1.OrthoProj(L2.Head, HeadData); // = head of line2 on line1
          L1.OrthoProj(L2.Tail, TailData); // = tail of line2 on line1

          if (HeadData.Distance < 0) and (TailData.Distance < 0) then
            Break;
          if (HeadData.Distance < 0) and (TailData.Distance < 0) then
            Break;


          // do they overlap?
          if (HeadData.Distance < 0) or (HeadData.Distance > 1) then
            Break;

          // head equal?
          if FBorderLines[I].Head = FBorderLines[J].Head then
          begin
            // move lineI SV and shorten lineI DV, remove lineJ
            FBorderLines[I].SV := FBorderLines[I].GetPoint(Tail);
            FBorderLines[I].DV := FBorderLines[I].DV * (1 - Tail);
            MustRemove.Toggle(J);
          end
          // tail equal?
          else if FBorderLines[I].Tail = FBorderLines[J].Tail then
          begin
            // move lineI SV and shorten lineI DV, remove lineJ
          end;




        end;
      end;

  // remove marked duplicates from back
  for I in MustRemove.Reversed do
  begin
    if I <> Length(FBorderLines) - 1 then
      Move(FBorderLines[I + 1], FBorderLines[I], (Length(FBorderLines) - I - 1) * SizeOf(FBorderLines[I]));
    SetLength(FBorderLines, Length(FBorderLines) - 1);
  end;

  MustRemove.Free;

  // Generate Points
  for L in FBorderLines do
  begin
    FBorderPoints.Add(L.Head);
    FBorderPoints.Add(L.Tail);
  end;

  FBorderGenerated := True;
  }
end;

constructor TTrianglePlane.Create;
begin
  FBorderPoints := TUniquePointList2.Create;
end;

destructor TTrianglePlane.Destroy;
begin
  FBorderPoints.Free;
  inherited Destroy;
end;

procedure TTrianglePlane.AddTriangle(ATriangle: TTriangle);
begin
  SetLength(FTriangles, Length(FTriangles) + 1);
  FTriangles[Length(FTriangles) - 1] := ATriangle;
  FBorderGenerated := False;
end;

function TTrianglePlane.Surrounds(AOther: TTrianglePlane): Boolean;
var
  Point: TGVector2;
  Triangle: TTriangle;
  L1, L2: TGLine2;
  Found: Boolean;
begin
  GenerateBorder;
  AOther.GenerateBorder;

  // check if all points of other polygon are inside/on polygon
  for Point in AOther.FBorderPoints do
  begin
    Found := False;
    for Triangle in FTriangles do
      if Triangle.TestPoint(Point) in [ptInside, ptBorder] then
      begin
        Found := True;
        Break;
      end;
    if not Found then
      Exit(False);
  end;

  // check if no point is inside other polygon
  for Point in FBorderPoints do
    for Triangle in FTriangles do
      if Triangle.TestPoint(Point) = ptInside then
        Exit(False);

  // check for side intersections
  for L1 in FBorderLines do
    for L2 in AOther.FBorderLines do
      if L1.Intsec(L2) then // intersects
        Exit(False);

  Result := True;
end;

{ TTriangle }

function TTriangle.GetPoint(AIndex: TTriangleSide): TGVector2;
begin
  Result := FPoints[AIndex];
end;

function TTriangle.GetLine(AIndex: TTriangleSide): TGLine2;
begin
  Result := FPoints[AIndex].LineTo(FPoints[(AIndex + 1) mod (High(TTriangleSide) + 1)]);
end;

procedure TTriangle.SetPoint(AIndex: TTriangleSide; AValue: TGVector2);
begin
  FPoints[AIndex] := AValue;
end;

constructor TTriangle.Create(APoints: TTrianglePoints);
begin
  FPoints := APoints;
end;

function TTriangle.TestPoint(APoint: TGVector2): TPointTestResult;
var
  I: TTriangleSide;
  CheckSide, Test: TLineSide;
begin
  CheckSide := Lines[0].PointLocation(Points[2]);

  for I := Low(TTriangleSide) to High(TTriangleSide) do
  begin
    Test := Lines[I].PointLocation(APoint);
    if Test = lsOn then
      Exit(ptBorder);
    if Test <> CheckSide then
      Exit(ptOutside);
  end;
  Result := ptInside;
end;

{ TGVector2LineHelper }

function TGVector2LineHelper.LineTo(AVector: TGVector2): TGLine2;
begin
  Result := TGLine2.Create(Self, Self.VectorTo(AVector));
end;

{ TGLine2 }

procedure TGLine2.FillM3x2Line2Intsec(const A: TGLine2);
begin
  M3x2[0, 0] := DV.X;
  M3x2[1, 0] := -A.DV.X;
  M3x2[2, 0] := A.SV.X - SV.X;
  M3x2[0, 1] := DV.Y;
  M3x2[1, 1] := -A.DV.Y;
  M3x2[2, 1] := A.SV.Y - SV.Y;
end;

function TGLine2.GetPoint(const Distance: Single): TGVector2;
begin
  Result := SV + Distance * DV;
end;

function TGLine2.Head: TGVector2;
begin
  Result := SV;
end;

function TGLine2.Tail: TGVector2;
begin
  Result := SV + DV;
end;

function TGLine2.IntsecOrTouch(const A: TGLine2): Boolean;
var
  R: TMatrixResult2;
begin
  FillM3x2Line2Intsec(A);
  if M3x2.Solve(R) then
    Exit((R[0] >= 0) and (R[0] <= 1) and (R[1] >= 0) and (R[1] <= 1));
  Result := False;
end;

function TGLine2.Intsec(const A: TGLine2): Boolean;
var
  R: TMatrixResult2;
begin
  FillM3x2Line2Intsec(A);
  if M3x2.Solve(R) then
    Exit((R[0] > 0) and (R[0] < 1) and (R[1] > 0) and (R[1] < 1));
  Result := False;
end;

function TGLine2.OrthoProj(const A: TGVector2): Boolean;
var
  Distance: Single;
begin
  Distance := DV.Dot(A - SV) / DV.SqrDot;
  Result := (Distance >= 0) and (Distance <= 1);
end;

function TGLine2.OrthoProj(const A: TGVector2; out AData: TOrthoProjData): Boolean;
begin
  AData.Distance := DV.Dot(A - SV) / DV.SqrDot;
  AData.Point := GetPoint(AData.Distance);
  AData.Height := (AData.Point - A).Length;
  Result := (AData.Distance >= 0) and (AData.Distance <= 1);
end;

function TGLine2.AngleTo(const A: TGLine2): Single;
begin
  Result := DV.AngleTo(A.DV);
end;

function TGLine2.EqualTo(const A: TGLine2; AIgnoreDir: Boolean): Boolean;
begin
  Result := (SV = A.SV) and (DV = A.DV) or
            AIgnoreDir and (SV + DV = A.SV) and (DV = -A.DV);
end;

function TGLine2.GetSlope(out FFlipped: Boolean): Single;
begin
  FFlipped := (DV.X < 0) or (DV.X = 0) and (DV.Y < 0);
  if DV.X = 0 then
    Exit(Infinity);
  Exit(DV.Y / DV.X);
end;

function TGLine2.PointLocation(A: TGVector2): TLineSide;
var
  Slope: Single;
  Flipped: Boolean;
begin
  A := A - SV;
  Slope := GetSlope(Flipped);
  if IsInfinite(Slope) then
  begin
    if A.X > 0 then
      Result := lsLeft
    else if A.X < 0 then
      Result := lsRight
    else
      Result := lsOn;
  end
  else if A.Y < Slope * A.X then
    Result := lsLeft
  else if A.Y > Slope * A.X then
    Result := lsRight
  else
    Result := lsOn;

  if Flipped then
  begin
    if Result = lsLeft then
      Result := lsRight
    else if Result = lsRight then
      Result := lsLeft;
  end;
end;

constructor TGLine2.Create(const SV, DV: TGVector);
begin
  Self.SV := SV;
  Self.DV := DV;
end;

{ TIntVector }

class operator TIntVector.Add(const A, B: TIntVector): TIntVector;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
end;

class operator TIntVector.Subtract(const A, B: TIntVector): TIntVector;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
end;

class operator TIntVector.Add(const A: TIntVector; B: Integer): TIntVector;
begin
  Result.X := A.X + B;
  Result.Y := A.Y + B;
  Result.Z := A.Z + B;
end;

class operator TIntVector.Subtract(const A: TIntVector; B: Integer): TIntVector;
begin
  Result.X := A.X - B;
  Result.Y := A.Y - B;
  Result.Z := A.Z - B;
end;

class operator TIntVector.Multiply(const A: TIntVector; B: Integer): TIntVector;
begin
  Result.X := A.X * B;
  Result.Y := A.Y * B;
  Result.Z := A.Z * B;
end;

class operator TIntVector.Multiply(A: Integer; const B: TIntVector): TIntVector;
begin
  Result.X := A * B.X;
  Result.Y := A * B.Y;
  Result.Z := A * B.Z;
end;

class operator TIntVector.IntDivide(const A: TIntVector; B: Integer): TIntVector;
begin
  Result.X := A.X div B;
  Result.Y := A.Y div B;
  Result.Z := A.Z div B;
end;

class operator TIntVector.IntDivide(A: Integer; const B: TIntVector): TIntVector;
begin
  Result.X := A div B.X;
  Result.Y := A div B.Y;
  Result.Z := A div B.Z;
end;

class operator TIntVector.Positive(const A: TIntVector): TIntVector;
begin
  Result := A;
end;

class operator TIntVector.Negative(const A: TIntVector): TIntVector;
begin
  Result.X := -A.X;
  Result.Y := -A.Y;
  Result.Z := -A.Z;
end;

class operator TIntVector.Equal(const A, B: TIntVector): Boolean;
begin
  Result := (A.X = B.X) and (A.Y = B.Y) and (A.Z = B.Z);
end;

class operator TIntVector.NotEqual(const A, B: TIntVector): Boolean;
begin
  Result := (A.X <> B.X) or (A.Y <> B.Y) or (A.Z <> B.Z);
end;

class operator TIntVector.LessThan(const A, B: TIntVector): Boolean;
begin
  Result := (A.X < B.X) and (A.Y < B.Y) and (A.Z < B.Z);
end;

class operator TIntVector.LessThanOrEqual(const A, B: TIntVector): Boolean;
begin
  Result := (A.X <= B.X) and (A.Y <= B.Y) and (A.Z <= B.Z);
end;

class operator TIntVector.GreaterThan(const A, B: TIntVector): Boolean;
begin
  Result := (A.X > B.X) and (A.Y > B.Y) and (A.Z > B.Z);
end;

class operator TIntVector.GreaterThanOrEqual(const A, B: TIntVector): Boolean;
begin
  Result := (A.X >= B.X) and (A.Y >= B.Y) and (A.Z >= B.Z);
end;

class operator TIntVector.Equal(const A: TIntVector; B: Integer): Boolean;
begin
  Result := (A.X = B) and (A.Y = B) and (A.Z = B);
end;

class operator TIntVector.NotEqual(const A: TIntVector; B: Integer): Boolean;
begin
  Result := (A.X <> B) or (A.Y <> B) or (A.Z <> B);
end;

class operator TIntVector.LessThan(const A: TIntVector; B: Integer): Boolean;
begin
  Result := (A.X < B) and (A.Y < B) and (A.Z < B);
end;

class operator TIntVector.LessThanOrEqual(const A: TIntVector; B: Integer): Boolean;
begin
  Result := (A.X <= B) and (A.Y <= B) and (A.Z <= B);
end;

class operator TIntVector.GreaterThan(const A: TIntVector; B: Integer): Boolean;
begin
  Result := (A.X > B) and (A.Y > B) and (A.Z > B);
end;

class operator TIntVector.GreaterThanOrEqual(const A: TIntVector; B: Integer): Boolean;
begin
  Result := (A.X >= B) and (A.Y >= B) and (A.Z >= B);
end;

class operator TIntVector.Implicit(const A: TIntVector): TGVector3;
begin
  Result.X := A.X;
  Result.Y := A.Y;
  Result.Z := A.Z;
end;

function TIntVector.ToString: String;
begin
  Result := Self;
end;

class operator TIntVector.Implicit(const A: TIntVector): String;
begin
  Result := Format('[%d|%d|%d]', [A.X, A.Y, A.Z]);
end;

class function TIntVector.Floor(const AVector: TGVector3): TIntVector;
begin
  Result.X := Math.Floor(AVector.X);
  Result.Y := Math.Floor(AVector.Y);
  Result.Z := Math.Floor(AVector.Z);
end;

class function TIntVector.Ceil(const AVector: TGVector3): TIntVector;
begin
  Result.X := Math.Ceil(AVector.X);
  Result.Y := Math.Ceil(AVector.Y);
  Result.Z := Math.Ceil(AVector.Z);
end;

constructor TIntVector.Create(AX, AY, AZ: Integer);
begin
  X := AX;
  Y := AY;
  Z := AZ;
end;

{ EBlockDirectionError }

constructor EBlockDirectionError.Create;
begin
  CreateFmt('Not all directions in BlockRotation!', []);
end;

{ TBlockRotation }

constructor TBlockRotation.Create;
begin
  Reset;
end;

constructor TBlockRotation.Create(AX, AY, AZ: TGBasicDir3);
var
  UsedDirections: TGBasicDirs3;
begin
  UsedDirections := [];
  Include(UsedDirections, AbsBasicDir(AX));
  Include(UsedDirections, AbsBasicDir(AY));
  Include(UsedDirections, AbsBasicDir(AZ));
  if UsedDirections = [sdRight, sdUp, sdFront] then
  begin
    FX := AX;
    FY := AY;
    FZ := AZ;
  end
  else
    raise EBlockDirectionError.Create;
end;

function TBlockRotation.Convert(ADirection: TGBasicDir3): TGBasicDir3;
begin
  case ADirection of
    sdRight:
      Exit(FX);
    sdLeft:
      Exit(InvertBasicDir(FX));
    sdUp:
      Exit(FY);
    sdDown:
      Exit(InvertBasicDir(FY));
    sdFront:
      Exit(FZ);
    else // sdBack
      Exit(InvertBasicDir(FZ));
  end;
end;

function TBlockRotation.ConvertBack(ADirection: TGBasicDir3): TGBasicDir3;
var
  M: TBlockRotation;
begin
  M := TBlockRotation.Create;
  M.FromMatrix(Matrix.Transpose);
  Result := M.Convert(ADirection);
  M.Free;
end;

function TBlockRotation.Matrix: TMatrix3;
  function IfOrThen(A, B: Boolean): Single;
  begin
    if A then
      Exit(1);
    if B then
      Exit(-1);
    Result := 0;
  end;

begin
  Result[0, 0] := IfOrThen(FX = sdRight, FX = sdLeft);
  Result[0, 1] := IfOrThen(FX = sdUp, FX = sdDown);
  Result[0, 2] := IfOrThen(FX = sdFront, FX = sdBack);
  Result[1, 0] := IfOrThen(FY = sdRight, FY = sdLeft);
  Result[1, 1] := IfOrThen(FY = sdUp, FY = sdDown);
  Result[1, 2] := IfOrThen(FY = sdFront, FY = sdBack);
  Result[2, 0] := IfOrThen(FZ = sdRight, FZ = sdLeft);
  Result[2, 1] := IfOrThen(FZ = sdUp, FZ = sdDown);
  Result[2, 2] := IfOrThen(FZ = sdFront, FZ = sdBack);
end;

procedure TBlockRotation.FromMatrix(AMatrix: TMatrix3);

  procedure DoIt(Index: Integer; out ADir: TGBasicDIr3);
  var
    I: Integer;
  begin
    for I := 0 to 2 do
      if AMatrix[Index, I] = 1 then
      begin
        ADir := TGBasicDir(1 + 2 * I);
        Break;
      end
      else if AMatrix[Index, I] = -1 then
      begin
        ADir := TGBasicDir(2 + 2 * I);
        Break;
      end;
  end;

begin
  DoIt(0, FX);
  DoIt(1, FY);
  DoIt(2, FZ);
end;

procedure TBlockRotation.Rotate(AAxis: TGBasicDir3; ASteps: Integer);
begin
  FX := RotateBasicDir(FX, AAxis, ASteps);
  FY := RotateBasicDir(FY, AAxis, ASteps);
  FZ := RotateBasicDir(FZ, AAxis, ASteps);
  FChanged := True;
end;

procedure TBlockRotation.Mirror(ANormal: TGBasicDir3);
var
  N: TGBasicDir3;
begin
  N := AbsBasicDir(ANormal);
  if N = AbsBasicDir(FX) then
    FX := InvertBasicDir(FX);
  if N = AbsBasicDir(FY) then
    FY := InvertBasicDir(FY);
  if N = AbsBasicDir(FZ) then
    FZ := InvertBasicDir(FZ);
end;

procedure TBlockRotation.Invert;
begin
  FromMatrix(Matrix.Transpose);
end;

procedure TBlockRotation.Reset;
begin
  FX := sdRight;
  FY := sdUp;
  FZ := sdFront;
  FChanged := True;
end;

function TBlockRotation.Equal(ABlockRotation: TBlockRotation): Boolean;
begin
  Result := (ABlockRotation <> nil) and
            (ABlockRotation.FX = FX) and
            (ABlockRotation.FY = FY) and
            (ABlockRotation.FZ = FZ);
end;

procedure TBlockRotation.Assign(ABlockRotation: TBlockRotation);
begin
  FX := ABlockRotation.FX;
  FY := ABlockRotation.FY;
  FZ := ABlockRotation.FZ;
  FChanged := True;
end;

function TBlockRotation.Changed: Boolean;
begin
  Result := FChanged;
end;

procedure TBlockRotation.NotifyChanges;
begin
  FChanged := False;
end;

{ TLocation }

procedure TLocation.TriggerChanges(AChanges: TLocationChanges);
begin
  FChanged := True;
  if AChanges - [lcFreeScale, lcFreeTranslation, lcFreeRotation] = AChanges then // free changes matrix > no notify
    FMatrixChanged := True;
  if Assigned(FOnChange) then
    FOnChange(AChanges);
end;

procedure TLocation.SetLook(AValue: TGVector3);
var
  D: TGDirection;
begin
  // Z points in other direction
  AValue.Z := -AValue.Z;
  D := TGDirection.FromVector(AValue);
  TurnAngle := D.TurnAngle;
  PitchAngle := D.PitchAngle;
end;

function TLocation.GetInvMatrix: TMatrix4;
begin
  if FMatrixChanged or FInvMatrixChanged then
    FInvMatrix := Matrix.Inverse;
  Result := FInvMatrix;
  FInvMatrixChanged := False;
end;

function TLocation.GetInvRotMatrix: TMatrix3;
begin
  if FMatrixChanged or FRotMatrixChanged or FInvRotMatrixChanged then
    FInvRotMatrix := RotMatrix.Inverse;
  Result := FInvRotMatrix;
  FInvRotMatrixChanged := False;
end;

procedure TLocation.SetScale(AValue: TGVector3);
begin
  if FScale = AValue then
    Exit;
  FScale := AValue;
  TriggerChanges([lcScale]);
end;

procedure TLocation.SetScaleX(AValue: Single);
begin
  if FScale.X = AValue then
    Exit;
  FScale.X := AValue;
  TriggerChanges([lcScale]);
end;

procedure TLocation.SetScaleY(AValue: Single);
begin
  if FScale.Y = AValue then
    Exit;
  FScale.Y := AValue;
  TriggerChanges([lcScale]);
end;

procedure TLocation.SetScaleZ(AValue: Single);
begin
  if FScale.Z = AValue then
    Exit;
  FScale.Z := AValue;
  TriggerChanges([lcScale]);
end;

function TLocation.GetLook: TGVector3;
begin
  if FMatrixChanged then
    BuildMatrix;
  Result := TGVector3.Create(
    -FMatrix[0, 2],
    -FMatrix[1, 2],
    -FMatrix[2, 2]
  );
end;

function TLocation.GetMatrix: TMatrix4;
begin
  if FMatrixChanged then
    BuildMatrix;
  FInvMatrixChanged := True;
  FRotMatrixChanged := True;
  Result := FMatrix;
end;

function TLocation.GetRealPosition: TGVector3;
begin
  Result := TGVector3.Create(
    Matrix[3, 0],
    Matrix[3, 1],
    Matrix[3, 2]
  );
  Result := Result * RotMatrix;
  if FInverted then
    Result := -Result;
end;

function TLocation.GetRight: TGVector3;
begin
  if FMatrixChanged then
    BuildMatrix;
  Result := TGVector3.Create(
    FMatrix[0, 0],
    FMatrix[1, 0],
    FMatrix[2, 0]
  );
end;

function TLocation.GetRotMatrix: TMatrix3;
begin
  if FMatrixChanged or FRotMatrixChanged then
    FRotMatrix := Matrix.Minor[3, 3];
  Result := FRotMatrix;
  FRotMatrixChanged := False;
  FInvRotMatrixChanged := True;
end;

function TLocation.GetUp: TGVector3;
begin
  if FMatrixChanged then
    BuildMatrix;
  Result := TGVector3.Create(
    FMatrix[0, 1],
    FMatrix[1, 1],
    FMatrix[2, 1]
  );
end;

procedure TLocation.BuildMatrix;
var
  OnChangeSave: TChangeProcedure;
begin
  OnChangeSave := FOnChange;
  FOnChange := nil;
  FMatrix.LoadIdentity;
  if FInverted then
  begin
    FreeTranslate(-FOffset);
    FreeScale(1 / FScale);
    FreeRoll(-FRoll);
    FreePitch(-FPitch);
    FreeTurn(-FTurn);
    FreeTranslate(-FPos);
  end
  else
  begin
    FreeTranslate(FPos);
    FreeTurn(FTurn);
    FreePitch(FPitch);
    FreeRoll(FRoll);
    FreeScale(FScale);
    FreeTranslate(FOffset);
  end;
  FMatrixChanged := False;
  FFreeChanged := False;
  FChanged := True;
  FOnChange := OnChangeSave;
end;

procedure TLocation.SetOffset(AValue: TGVector3);
begin
  if FOffset = AValue then
    Exit;
  FOffset := AValue;
  TriggerChanges([lcOffset]);
end;

procedure TLocation.SetOffsetX(AValue: Single);
begin
  if FOffset.X = AValue then
    Exit;
  FOffset.X := AValue;
  TriggerChanges([lcOffset]);
end;

procedure TLocation.SetOffsetY(AValue: Single);
begin
  if FOffset.Y = AValue then
    Exit;
  FOffset.Y := AValue;
  TriggerChanges([lcOffset]);
end;

procedure TLocation.SetOffsetZ(AValue: Single);
begin
  if FOffset.Z = AValue then
    Exit;
  FOffset.Z := AValue;
  TriggerChanges([lcOffset]);
end;

procedure TLocation.SetPitch(AValue: Single);
begin
  AValue := FMod(AValue, MinRotation, MaxRotation);
  if FPitch = AValue then
    Exit;
  FPitch := AValue;
  TriggerChanges([lcPitch]);
end;

procedure TLocation.SetPos(AValue: TGVector3);
begin
  if FPos = AValue then
    Exit;
  FPos := AValue;
  TriggerChanges([lcPosition]);
end;

procedure TLocation.SetPosX(AValue: Single);
begin
  if FPos.X = AValue then
    Exit;
  FPos.X := AValue;
  TriggerChanges([lcPosition]);
end;

procedure TLocation.SetPosY(AValue: Single);
begin
  if FPos.Y = AValue then
    Exit;
  FPos.Y := AValue;
  TriggerChanges([lcPosition]);
end;

procedure TLocation.SetPosZ(AValue: Single);
begin
  if FPos.Z = AValue then
    Exit;
  FPos.Z := AValue;
  TriggerChanges([lcPosition]);
end;

procedure TLocation.SetRoll(AValue: Single);
begin
  AValue := FMod(AValue, MinRotation, MaxRotation);
  if FRoll = AValue then
    Exit;
  FRoll := AValue;
  TriggerChanges([lcRoll]);
end;

procedure TLocation.SetTurn(AValue: Single);
begin
  AValue := FMod(AValue, MinRotation, MaxRotation);
  if FTurn = AValue then
    Exit;
  FTurn := AValue;
  TriggerChanges([lcTurn]);
end;

constructor TLocation.Create(AInverted: Boolean);
begin
  Reset;
  FInverted := AInverted;
end;

procedure TLocation.Slide(ADistance: Single; AHorizontal: Boolean);
begin
  if AHorizontal then
    Pos := Pos + Right * ADistance * UVecXZ
  else
    Pos := Pos + Right * ADistance;
end;

procedure TLocation.Lift(ADistance: Single; AYOnly: Boolean);
begin
  if AYOnly then
    Pos := Pos + Up * ADistance * UVecY
  else
    Pos := Pos + Up * ADistance;
end;

procedure TLocation.Move(ADistance: Single; AHorizontal: Boolean);
begin
  if AHorizontal then
    Pos := Pos + Look * ADistance * UVecXZ
  else
    Pos := Pos + Look * ADistance;
end;

procedure TLocation.LookAt(APoint: TGVector3);
begin
  Look := RealPosition.VectorTo(APoint);
end;

procedure TLocation.Reset;
begin
  Pos := Origin;
  Offset := Origin;
  Scale := UVecXYZ;
  FTurn := 0;
  FPitch := 0;
  FRoll := 0;
  FMatrix.LoadIdentity;
  FChanged := True;
  if Assigned(FOnChange) then
    FOnChange([lcPosition, lcOffset, lcScale, lcTurn, lcPitch, lcRoll]);
end;

procedure TLocation.ResetRotation;
begin
  if (FTurn = 0) and (FPitch = 0) and (FRoll = 0) then
    Exit;
  FTurn := 0;
  FPitch := 0;
  FRoll := 0;
  TriggerChanges([lcTurn, lcPitch, lcRoll]);
end;

procedure TLocation.ResetTranslation;
begin
  if Pos = Origin then
    Exit;
  Pos := Origin;
  TriggerChanges([lcPosition]);
end;

procedure TLocation.ResetOffset;
begin
  if Offset = Origin then
    Exit;
  Offset := Origin;
  TriggerChanges([lcOffset]);
end;

procedure TLocation.ResetScale;
begin
  if Scale = UVecXYZ then
    Exit;
  Scale := UvecXYZ;
  TriggerChanges([lcScale]);
end;

procedure TLocation.Turn(const ATurn: Single);
begin
  TurnAngle := FTurn + ATurn;
end;

procedure TLocation.Pitch(const APitch: Single);
begin
  PitchAngle := FPitch + APitch;
end;

procedure TLocation.Roll(const ARoll: Single);
begin
  RollAngle := FRoll + ARoll;
end;

procedure TLocation.FreeTurn(ATurn: Single);
var
  M: TMatrix4;
begin
  ATurn := ATurn * Pi / 180;
  M.LoadIdentity;
  M[0, 0] :=  cos(ATurn);
  M[2, 0] := -sin(ATurn);
  M[0, 2] :=  sin(ATurn);
  M[2, 2] :=  cos(ATurn);
  FMatrix := FMatrix * M;
  FFreeChanged := True;
  TriggerChanges([lcFreeRotation]);
end;

procedure TLocation.FreePitch(APitch: Single);
var
  M: TMatrix4;
begin
  APitch := APitch * Pi / 180;
  M.LoadIdentity;
  M[1, 1] :=  cos(APitch);
  M[2, 1] := -sin(APitch);
  M[1, 2] :=  sin(APitch);
  M[2, 2] :=  cos(APitch);
  FMatrix := FMatrix * M;
  FFreeChanged := True;
  TriggerChanges([lcFreeRotation]);
end;

procedure TLocation.FreeRoll(ARoll: Single);
var
  M: TMatrix4;
begin
  ARoll := ARoll * Pi / 180;
  M.LoadIdentity;
  M[0, 0] :=  cos(ARoll);
  M[1, 0] := -sin(ARoll);
  M[0, 1] :=  sin(ARoll);
  M[1, 1] :=  cos(ARoll);
  FMatrix := FMatrix * M;
  FFreeChanged := True;
  TriggerChanges([lcFreeRotation]);
end;

procedure TLocation.FreeTranslate(const AVector: TGVector3);
var
  M: TMatrix4;
begin
  M.LoadIdentity;
  M[3, 0] := AVector.X;
  M[3, 1] := AVector.Y;
  M[3, 2] := AVector.Z;
  FMatrix := FMatrix * M;
  FFreeChanged := True;
  TriggerChanges([lcFreeTranslation]);
end;

procedure TLocation.FreeScale(const AScale: TGVector3);
var
  M: TMatrix4;
begin
  M.Clear;
  M[0, 0] := AScale.X;
  M[1, 1] := AScale.Y;
  M[2, 2] := AScale.Z;
  M[3, 3] := 1;
  FMatrix := FMatrix * M;
  FFreeChanged := True;
  TriggerChanges([lcFreeScale]);
end;

procedure TLocation.FreeMirror(ANormal: TGLine);
var
  R, U, L, P: TGVector3;
begin
  R := ANormal.DV.MirrorOther(Right);
  U := ANormal.DV.MirrorOther(Up);
  L := ANormal.DV.MirrorOther(Look);
  P := ANormal.MirrorVector(RealPosition);
  // Right
  FMatrix[0, 0] := R.X;
  FMatrix[1, 0] := R.Y;
  FMatrix[2, 0] := R.Z;
  // Up
  FMatrix[0, 1] := U.X;
  FMatrix[1, 1] := U.Y;
  FMatrix[2, 1] := U.Z;
  // Down
  FMatrix[0, 2] := L.X;
  FMatrix[1, 2] := L.Y;
  FMatrix[2, 2] := L.Z;
  // Position
  FMatrix[3, 0] := P.X;
  FMatrix[3, 1] := P.Y;
  FMatrix[3, 2] := P.Z;

  FFreeChanged := True;
  TriggerChanges([lcFreeMirror]);
end;

procedure TLocation.FromMatrix(AMatrix: TMatrix4);
begin
  FMatrix := AMatrix;
  FFreeChanged := True;
  TriggerChanges([lcFreeRotation, lcFreeScale, lcFreeTranslation]);
end;

procedure TLocation.FromRotMatrix(AMatrix: TMatrix3);
begin
  FMatrix.Minor[3, 3] := AMatrix;
  FFreeChanged := True;
  TriggerChanges([lcFreeRotation, lcFreeScale]);
end;

procedure TLocation.Translate(const AVector: TGVector3);
begin
  FPos := FPos + AVector;
  TriggerChanges([lcPosition]);
end;

procedure TLocation.MoveOffset(const AVector: TGVector3);
begin
  FOffset := FOffset + AVector;
  TriggerChanges([lcOffset]);
end;

procedure TLocation.ScaleBy(const AScale: TGVector3);
begin
  Scale := Scale * AScale;
end;

procedure TLocation.Approach(ALocation: TLocation; ADelta: Single);

  function ApproachRotation(Value, Final: Single): Single;
  begin
    if Value - Final > 180 then
      Final := Final + 360
    else if Value - Final < -180 then
      Final := Final - 360;

    Result := (1 - ADelta) * Value + ADelta * Final
  end;

begin
  ADelta := EnsureRange(ADelta, 0, 1);

  Pos := (1 - ADelta) * Pos + ADelta * ALocation.Pos;
  Offset := (1 - ADelta) * Offset + ADelta * ALocation.Offset;
  Scale := (1 - ADelta) * Scale + ADelta * ALocation.Scale;

  TurnAngle := ApproachRotation(TurnAngle, ALocation.TurnAngle);
  PitchAngle := ApproachRotation(PitchAngle, ALocation.PitchAngle);
  RollAngle := ApproachRotation(RollAngle, ALocation.RollAngle);

end;

procedure TLocation.Assign(ALocation: TLocation);
begin
  Pos := ALocation.Pos;
  Offset := ALocation.Offset;
  Scale := ALocation.Scale;
  TurnAngle := ALocation.TurnAngle;
  PitchAngle := ALocation.PitchAngle;
  RollAngle := ALocation.RollAngle;
end;

procedure TLocation.Swap(ALocation: TLocation);
var
  Tmp: TLocation;
begin
  Tmp := TLocation.Create;
  Tmp.Assign(ALocation);
  ALocation.Assign(Self);
  Self.Assign(Tmp);
  Tmp.Free;
end;

procedure TLocation.NotifyChanges;
begin
  FChanged := False;
end;

procedure TLocation.FreeRotate(AVector: TGVector3; const AAngle: Single);
var
  S, C, CInv: Single;
  M: TMatrix4;
begin
  AVector := AVector.Normalize;

  S := Sin(AAngle / 180 * Pi);
  C := Cos(AAngle / 180 * Pi);
  CInv := 1 - C;

  M.Clear;
  // right
  M[0, 0] := AVector.X * AVector.X * CInv + C;
  M[0, 1] := AVector.Y * AVector.X * CInv + AVector.Z * S;
  M[0, 2] := AVector.Z * AVector.X * CInv - AVector.Y * S;
  // up
  M[1, 0] := AVector.X * AVector.Y * CInv - AVector.Z * S;
  M[1, 1] := AVector.Y * AVector.Y * CInv + C;
  M[1, 2] := AVector.Z * AVector.Y * CInv + AVector.X * S;
  // look
  M[2, 0] := AVector.X * AVector.Z * CInv + AVector.Y * S;
  M[2, 1] := AVector.Y * AVector.Z * CInv - AVector.X * S;
  M[2, 2] := AVector.Z * AVector.Z * CInv + C;

  M[3, 3] := 1;

  FMatrix := FMatrix * M;

  TriggerChanges([lcFreeRotation]);
end;

{ TGVector2 }

class operator TGVector2.Add(const A, B: TGVector2): TGVector2;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
end;

class operator TGVector2.Subtract(const A, B: TGVector2): TGVector2;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
end;

class operator TGVector2.Add(const A: TGVector2; const V: Single): TGVector2;
begin
  Result.X := A.X + V;
  Result.Y := A.Y + V;
end;

class operator TGVector2.Subtract(const A: TGVector2; const V: Single): TGVector2;
begin
  Result.X := A.X - V;
  Result.Y := A.Y - V;
end;

class operator TGVector2.Multiply(const V: Single; const A: TGVector2): TGVector2;
begin
  Result.X := V * A.X;
  Result.Y := V * A.Y;
end;

class operator TGVector2.Multiply(const A: TGVector2; const V: Single): TGVector2;
begin
  Result.X := V * A.X;
  Result.Y := V * A.Y;
end;

class operator TGVector2.Multiply(const A, B: TGVector2): TGVector2;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
end;

class operator TGVector2.Divide(const V: Single; const A: TGVector2): TGVector2;
begin
  Result.X := V / A.X;
  Result.Y := V / A.Y;
end;

class operator TGVector2.Divide(const A: TGVector2; const V: Single): TGVector2;
begin
  Result.X := A.X / V;
  Result.Y := A.Y / V;
end;

class operator TGVector2.Divide(const A, B: TGVector2): TGVector2;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
end;

class operator TGVector2.Positive(const A: TGVector2): TGVector2;
begin
  Result := A;
end;

class operator TGVector2.Negative(const A: TGVector2): TGVector2;
begin
  Result.X := -A.X;
  Result.Y := -A.Y;
end;

class operator TGVector2.Equal(const A, B: TGVector2): Boolean;
begin
  Result := (A.X = B.X) and (A.Y = B.Y);
end;

class operator TGVector2.NotEqual(const A, B: TGVector2): Boolean;
begin
  Result := (A.X <> B.X) or (A.Y <> B.Y);
end;

class operator TGVector2.LessThan(const A, B: TGVector2): Boolean;
begin
  Result := (A.X < B.X) and (A.Y < B.Y);
end;

class operator TGVector2.LessThanOrEqual(const A, B: TGVector2): Boolean;
begin
  Result := (A.X <= B.X) and (A.Y <= B.Y);
end;

class operator TGVector2.GreaterThan(const A, B: TGVector2): Boolean;
begin
  Result := (A.X > B.X) and (A.Y > B.Y);
end;

class operator TGVector2.GreaterThanOrEqual(const A, B: TGVector2): Boolean;
begin
  Result := (A.X >= B.X) and (A.Y >= B.Y);
end;

class operator TGVector2.Implicit(const A: TGVector3): TGVector2;
begin
  Result.X := A.X;
  Result.Y := A.Y;
end;

class operator TGVector2.Implicit(const A: TGVector4): TGVector2;
begin
  Result.X := A.X;
  Result.Y := A.Y;
end;

class operator TGVector2.Implicit(const A: TGVector2): TGVector4;
begin
  Result.X := A.X;
  Result.Y := A.Y;
  Result.Z := 0;
  Result.W := 1;
end;

class operator TGVector2.Implicit(const A: TGVector2): TGVector3;
begin
  Result.X := A.X;
  Result.Y := A.Y;
  Result.Z := 0;
end;

class operator TGVector2.Implicit(const A: TGVector2): String;
begin
  Result := Format('[%f|%f]', [A.X, A.Y]);
end;

function TGVector2.ToVec3(const Z: Single): TGVector3;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
end;

function TGVector2.ToVec4(const Z: Single; const W: Single): TGVector4;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
  Result.W := W;
end;

function TGVector2.Cross: TGVector2;
begin
  Result.X := -Y;
  Result.Y := X;
end;

function TGVector2.Dot(const A: TGVector2): Single;
begin
  Result := X * A.X + Y * A.Y;
end;

function TGVector2.SqrDot: Single;
begin
  Result := Sqr(X) + Sqr(Y);
end;

function TGVector2.Length: Single;
begin
  Result := Sqrt(SqrDot);
end;

function TGVector2.DistanceTo(const A: TGVector2): Single;
begin
  Result := VectorTo(A).Length;
end;

function TGVector2.VectorTo(const A: TGVector2): TGVector2;
begin
  Result := A - Self;
end;

function TGVector2.Normalize: TGVector2;
begin
  Result := Self / Length;
end;

function TGVector2.Abs: TGVector2;
begin
  Result.X := System.Abs(X);
  Result.Y := System.Abs(Y);
end;

function TGVector2.GetCosAngle(const A: TGVector2): Single;
begin
  Result := EnsureRange(Dot(A) / (Length * A.Length), -1, 1);
end;

function TGVector2.AngleTo(const A: TGVector2): Single;
begin
  Result := ArcCos(EnsureRange(Dot(A) / (Length * A.Length), -1, 1)) * 180 / Pi;
end;

function TGVector2.Floor: TGVector2;
begin
  Result.X := Math.Floor(X);
  Result.Y := Math.Floor(Y);
end;

function TGVector2.Ceil: TGVector2;
begin
  Result.X := Math.Ceil(X);
  Result.Y := Math.Ceil(Y);
end;

function TGVector2.ToString: String;
begin
  Result := Self;
end;

function TGVector2.Rotate(Angle: Single): TGVector2;
begin
  Angle := Angle * Pi / 180;
  Result := Sin(Angle) * Cross + Cos(Angle) * Self;
end;

constructor TGVector2.Create(const X, Y: Single);
begin
  Self.X := X;
  Self.Y := Y;
end;

class function TGVector2.VecXY(const A: TGVector3): TGVector2;
begin
  Result.X := A.X;
  Result.Y := A.Y;
end;

class function TGVector2.VecYX(const A: TGVector3): TGVector2;
begin
  Result.X := A.Y;
  Result.Y := A.X;
end;

class function TGVector2.VecYZ(const A: TGVector3): TGVector2;
begin
  Result.X := A.Y;
  Result.Y := A.Z;
end;

class function TGVector2.VecZY(const A: TGVector3): TGVector2;
begin
  Result.X := A.Z;
  Result.Y := A.Y;
end;

class function TGVector2.VecZX(const A: TGVector3): TGVector2;
begin
  Result.X := A.Z;
  Result.Y := A.X;
end;

class function TGVector2.VecXZ(const A: TGVector3): TGVector2;
begin
  Result.X := A.X;
  Result.Y := A.Z;
end;

{ TGVector3 }

class operator TGVector3.Add(const A, B: TGVector3): TGVector3;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
end;

class operator TGVector3.Subtract(const A, B: TGVector3): TGVector3;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
end;

class operator TGVector3.Add(const A: TGVector3; const V: Single): TGVector3;
begin
  Result.X := A.X + V;
  Result.Y := A.Y + V;
  Result.Z := A.Z + V;
end;

class operator TGVector3.Subtract(const A: TGVector3; const V: Single): TGVector3;
begin
  Result.X := A.X - V;
  Result.Y := A.Y - V;
  Result.Z := A.Z - V;
end;

class operator TGVector3.Multiply(const V: Single; const A: TGVector3): TGVector3;
begin
  Result.X := V * A.X;
  Result.Y := V * A.Y;
  Result.Z := V * A.Z;
end;

class operator TGVector3.Multiply(const A: TGVector3; const V: Single): TGVector3;
begin
  Result.X := A.X * V;
  Result.Y := A.Y * V;
  Result.Z := A.Z * V;
end;

class operator TGVector3.Multiply(const A, B: TGVector3): TGVector3;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
  Result.Z := A.Z * B.Z;
end;

class operator TGVector3.Multiply(const A: TMatrix3; const B: TGVector3): TGVector3;
begin
  Result.X := A[0, 0] * B.X + A[1, 0] * B.Y + A[2, 0] * B.Z;
  Result.Y := A[0, 1] * B.X + A[1, 1] * B.Y + A[2, 1] * B.Z;
  Result.Z := A[0, 2] * B.X + A[1, 2] * B.Y + A[2, 2] * B.Z;
end;

class operator TGVector3.Multiply(const B: TGVector3; const A: TMatrix3): TGVector3;
begin
  Result.X := A[0, 0] * B.X + A[0, 1] * B.Y + A[0, 2] * B.Z;
  Result.Y := A[1, 0] * B.X + A[1, 1] * B.Y + A[1, 2] * B.Z;
  Result.Z := A[2, 0] * B.X + A[2, 1] * B.Y + A[2, 2] * B.Z;
end;

class operator TGVector3.Divide(const V: Single; const A: TGVector3): TGVector3;
begin
  Result.X := V / A.X;
  Result.Y := V / A.Y;
  Result.Z := V / A.Z;
end;

class operator TGVector3.Divide(const A: TGVector3; const V: Single): TGVector3;
begin
  Result.X := A.X / V;
  Result.Y := A.Y / V;
  Result.Z := A.Z / V;
end;

class operator TGVector3.Divide(const A, B: TGVector3): TGVector3;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
  Result.Z := A.Z / B.Z;
end;

class operator TGVector3.Positive(const A: TGVector3): TGVector3;
begin
  Result := A;
end;

class operator TGVector3.Negative(const A: TGVector3): TGVector3;
begin
  Result.X := -A.X;
  Result.Y := -A.Y;
  Result.Z := -A.Z;
end;

class operator TGVector3.Equal(const A, B: TGVector3): Boolean;
begin
  Result := (A.X = B.X) and (A.Y = B.Y) and (A.Z = B.Z);
end;

class operator TGVector3.NotEqual(const A, B: TGVector3): Boolean;
begin
  Result := (A.X <> B.X) or (A.Y <> B.Y) or (A.Z <> B.Z);
end;

class operator TGVector3.LessThan(const A, B: TGVector3): Boolean;
begin
  Result := (A.X < B.X) and (A.Y < B.Y) and (A.Z < B.Z);
end;

class operator TGVector3.LessThanOrEqual(const A, B: TGVector3): Boolean;
begin
  Result := (A.X <= B.X) and (A.Y <= B.Y) and (A.Z <= B.Z);
end;

class operator TGVector3.GreaterThan(const A, B: TGVector3): Boolean;
begin
  Result := (A.X > B.X) and (A.Y > B.Y) and (A.Z > B.Z);
end;

class operator TGVector3.GreaterThanOrEqual(const A, B: TGVector3): Boolean;
begin
  Result := (A.X >= B.X) and (A.Y >= B.Y) and (A.Z >= B.Z);
end;

class operator TGVector3.Implicit(const A: TGVector4): TGVector3;
begin
  Result.X := A.X;
  Result.Y := A.Y;
  Result.Z := A.Z;
end;

class operator TGVector3.Implicit(const A: TGVector3): TGVector4;
begin
  Result.X := A.X;
  Result.Y := A.Y;
  Result.Z := A.Z;
  Result.W := 1;
end;

class operator TGVector3.Implicit(const A: TGVector3): String;
begin
  Result := Format('[%f|%f|%f]', [A.X, A.Y, A.Z]);
end;

function TGVector3.ToVec4(const W: Single): TGVector4;
begin
  Result.X := X;
  Result.Y := Y;
  Result.Z := Z;
  Result.W := W;
end;

function TGVector3.Cross(const A: TGVector3): TGVector3;
begin
  if (Self = Origin) or (A = Origin) then
    Result := Origin
  else
  begin
    Result.X := Y * A.Z - Z * A.Y;
    Result.Y := Z * A.X - X * A.Z;
    Result.Z := X * A.Y - Y * A.X;
  end;
end;

function TGVector3.Dot(const A: TGVector3): Single;
begin
  Result := X * A.X + Y * A.Y + Z * A.Z;
end;

function TGVector3.SqrDot: Single;
begin
  Result := Sqr(X) + Sqr(Y) + Sqr(Z);
end;

function TGVector3.Length: Single;
begin
  Result := Sqrt(SqrDot);
end;

function TGVector3.DistanceTo(const A: TGVector3): Single;
begin
  Result := (A - Self).Length;
end;

function TGVector3.VectorTo(A: TGVector3): TGVector3;
begin
  Result := A - Self;
end;

function TGVector3.Normalize: TGVector3;
begin
  Result := Self / Length;
end;

function TGVector3.Abs: TGVector3;
begin
  Result.X := System.Abs(X);
  Result.Y := System.Abs(Y);
  Result.Z := System.Abs(Z);
end;

function TGVector3.GetCosAngle(const A: TGVector3): Single;
begin
  Result := EnsureRange(Dot(A) / (Length * A.Length), -1, 1);
end;

function TGVector3.AngleTo(const A: TGVector3): Single;
begin
  Result := ArcCos(GetCosAngle(A)) * 180 / Pi;
end;

function TGVector3.Floor: TGVector3;
begin
  Result.X := Math.Floor(X);
  Result.Y := Math.Floor(Y);
  Result.Z := Math.Floor(Z);
end;

function TGVector3.Ceil: TGVector3;
begin
  Result.X := Math.Ceil(X);
  Result.Y := Math.Ceil(Y);
  Result.Z := Math.Ceil(Z);
end;

function TGVector3.MirrorOther(const A: TGVector3): TGVector3;
begin
  Result := A - 2 * Self.Dot(A) * Self;
end;

function TGVector3.ToString: String;
begin
  Result := Self;
end;

function TGVector3.Rotate(A: TGVector3; Angle: Single): TGVector3;
var
  UX, UZ: TGVector3;
  VX, VY, UXsqr, Asqr: Single;
begin
  Angle := Angle * Pi / 180;

  A := A.Normalize;

  UZ := Self.Cross(A);
  UX := A.Cross(UZ);

  UXsqr := UX.SqrDot;
  Asqr := A.SqrDot;
  if (UXsqr = 0) or (Asqr = 0) then
    Exit(A);
  VX := UX.Dot(Self) / UXsqr;
  VY := A.Dot(Self) / Asqr;

  Result := Cos(Angle) * VX * UX + VY * A + Sin(Angle) * VX * UZ;
end;

constructor TGVector3.Create(const X, Y, Z: Single);
begin
  Self.X := X;
  Self.Y := Y;
  Self.Z := Z;
end;

class function TGVector3.Random: TGVector3;
var
  O, U: Single;
begin
  O := System.Random * 2 * PI;
  U := System.Random * 2 - 1;
  Result.X := sqrt(1 - sqr(U)) * sin(O);
  Result.Y := sqrt(1 - sqr(U)) * cos(O);
  Result.Z := U;
end;

{ TGLine }

procedure TGLine.FillM3x2LineIntsec(const A: TGLine);
begin
  M3x2[0, 0] := Self.DV.X;
  M3x2[1, 0] := A.DV.X;
  M3x2[2, 0] := A.SV.X - Self.SV.X;
  M3x2[0, 1] := Self.DV.Y;
  M3x2[1, 1] := A.DV.Y;
  M3x2[2, 1] := A.SV.Y - Self.SV.Y;
end;

function TGLine.GetPoint(Distance: Single): TGVector3;
begin
  Result := Self.SV + Self.DV * Distance;
end;

function TGLine.Head: TGVector3;
begin
  Result := SV;
end;

function TGLine.Tail: TGVector3;
begin
  Result := SV + DV
end;

function TGLine.LineIntsec(const A: TGLine; out P: TGVector3): Boolean;
var
  S: Single;
begin
  if Intsec(A, S) then
  begin
    Result := True;
    P := GetPoint(S);
  end
  else
    Result := False;
end;

function TGLine.MirrorVector(AVector: TGVector3): TGVector3;
begin
  Result := AVector - SV;
  Result := DV.Normalize.MirrorOther(Result);
  Result := Result + SV;
end;

constructor TGLine.Create(const SV, DV: TGVector3);
begin
  Self.SV := SV;
  Self.DV := DV;
end;

function TGLine.OrthoProj(const A: TGVector3): Boolean;
var
  Distance: Single;
begin
  Distance := OrthoProjDistance(A);
  Result := (Distance >= 0) and (Distance <= 1);
end;

function TGLine.OrthoProj(const A: TGVector3; out AData: TOrthoProjData): Boolean;
begin
  AData.Distance := OrthoProjDistance(A);
  AData.Point := GetPoint(AData.Distance);
  AData.Height := (AData.Point - A).Length;
  Result := (AData.Distance >= 0) and (AData.Distance <= 1);
end;

function TGLine.OrthoProjDistance(const A: TGVector3): Single;
begin
  Result := DV.Dot(A - SV) / DV.SqrDot;
end;

function TGLine.Intsec(const A: TGLine): Boolean;
var
  P: TMatrixResult2;
begin
  FillM3x2LineIntsec(A);
  if M3x2.Solve(P) then
    Result := (P[0] * Self.DV.Z + P[1] * A.DV.Z) = (A.SV.Z - Self.SV.Z)
  else
    Result := False;
end;

function TGLine.Intsec(const A: TGLine; out S: Single): Boolean;
var
  P: TMatrixResult2;
begin
  FillM3x2LineIntsec(A);
  if M3x2.Solve(P) then
  begin
    Result := (P[0] * Self.DV.Z + P[1] * A.DV.Z) <> (A.SV.Z - Self.SV.Z);
    if Result then
       S := P[0];
  end
  else
    Result := False;
end;

{ TGPlane }

procedure TGPlane.FillM4x3LineIntsec(const A: TGLine);
begin
  M4x3[0, 0] := Self.DVS.X;
  M4x3[1, 0] := Self.DVT.X;
  M4x3[2, 0] := -A.DV.X;
  M4x3[3, 0] := A.SV.X - Self.SV.X;
  M4x3[0, 1] := Self.DVS.Y;
  M4x3[1, 1] := Self.DVT.Y;
  M4x3[2, 1] := -A.DV.Y;
  M4x3[3, 1] := A.SV.Y - Self.SV.Y;
  M4x3[0, 2] := Self.DVS.Z;
  M4x3[1, 2] := Self.DVT.Z;
  M4x3[2, 2] := -A.DV.Z;
  M4x3[3, 2] := A.SV.Z - Self.SV.Z;
end;

procedure TGPlane.FillM3x2PointIntsec(const A: TGVector);
begin
  // A.X = SV.X + S * DVS.X + T * DVT.X
  // A.Y = SV.Y + S * DVS.Y + T * DVT.Y
  // A.Z = SV.Z + S * DVS.Z + T * DVT.Z

  M3x2[0, 0] := Self.DVS.X;
  M3x2[1, 0] := Self.DVT.X;
  M3x2[2, 0] := A.X - Self.SV.X;
  M3x2[0, 1] := Self.DVS.Y;
  M3x2[1, 1] := Self.DVT.Y;
  M3x2[2, 1] := A.Y - Self.SV.Y;
end;

class operator TGPlane.Equal(const A, B: TGPlane): Boolean;
begin
  Result := (A.SV = B.SV) and (A.DVS = B.DVS) and (A.DVT = B.DVT);
end;

function TGPlane.PointIntsec(const A: TGVector3; out AData: TPointIntsecData): Boolean;
var
  R: TMatrixResult2;
begin
  FillM3x2PointIntsec(A);
  Result := M3x2.Solve(R);
  if not Result then
    Exit;
  AData.PlaneCoord.S := R[0];
  AData.PlaneCoord.T := R[1];
  Result := Self[AData.PlaneCoord] = A;
end;

function TGPlane.LineIntsec(const A: TGLine): Boolean;
begin
  FillM4x3LineIntsec(A);
  Result := M4x3.Solveable;
end;

function TGPlane.LineIntsec(const A: TGLine; out AData: TLineIntsecData): Boolean;
var
  R: TMatrixResult3;
begin
  FillM4x3LineIntsec(A);
  Result := M4x3.Solve(R);
  AData.Distance := R[2];
  AData.PlaneCoord := TGVector2.Create(R[0], R[1]);
  AData.Point := GetPoint(R[0], R[1]);
end;

procedure TGPlane.OrthoProj(const A: TGVector3; out AData: TOrthoProjData);
begin
  // yes, this is probably the fastest i can get :)
  AData.PlaneCoord.X := (DVT.SqrDot * DVS.Dot(A - SV) - DVT.Dot(DVS) * DVT.Dot(A - SV)) /
                        (DVS.SqrDot * DVT.SqrDot - Sqr(DVS.Dot(DVT)));
  AData.PlaneCoord.Y := (DVS.SqrDot * DVT.Dot(A - SV) - DVS.Dot(DVT) * DVS.Dot(A - SV)) /
                        (DVT.SqrDot * DVS.SqrDot - Sqr(DVT.Dot(DVS)));
  AData.Point := GetPoint(AData.PlaneCoord);
  AData.Height := (AData.Point - A).Length;
end;

function TGPlane.GetAreaQuad: Single;
begin
  Result := DVS.Cross(DVT).Length;
end;

function TGPlane.GetAreaTri: Single;
begin
  Result := DVS.Cross(DVT).Length / 2;
end;

function TGPlane.GetParaPoint: TGVector3;
begin
  Result := GetPoint(1, 1);
end;

function TGPlane.GetPoint(V: TGVector2): TGVector3;
begin
  Result := SV + V.X * DVS + V.Y * DVT;
end;

function TGPlane.GetPoint(S, T: Single): TGVector3;
begin
  Result := SV + S * DVS + T * DVT;
end;

function TGPlane.LineInQuad(const A: TGLine; out AData: TLineIntsecData; const ACheckScale: Single): Boolean;
var
  C: TGVector2;
begin
  Result := LineIntsec(A, AData);
  if not Result then
    Exit;
  C := (AData.PlaneCoord - 0.5) / ACheckScale + 0.5;
  Result := (C.X >= 0) and
            (C.X <= 1) and
            (C.Y >= 0) and
            (C.Y <= 1);
end;

function TGPlane.LineInTri(const A: TGLine; out AData: TLineIntsecData; const ACheckScale: Single): Boolean;
var
  C: TGVector2;
begin
  Result := LineIntsec(A, AData);
  if not Result then
    Exit;
  C := (AData.PlaneCoord - 0.5) / ACheckScale + 0.5;
  Result := (C.X >= 0) and
            (C.Y >= 0) and
            (C.X + C.Y <= 1);
end;

function TGPlane.LineInCircle(const A: TGLine; out AData: TLineIntsecData; const ACheckScale: Single): Boolean;
var
  C: TGVector2;
begin
  Result := LineIntsec(A, AData);
  if not Result then
    Exit;
  C := (AData.PlaneCoord - 0.5) / ACheckScale + 0.5;
  Result := C.Length < 1;
end;

function TGPlane.LineInQuad(const A: TGLine; const ACheckScale: Single): Boolean;
var
  AData: TLineIntsecData;
begin
  Result := LineInQuad(A, AData, ACheckScale);
end;

function TGPlane.LineInTri(const A: TGLine; const ACheckScale: Single): Boolean;
var
  AData: TLineIntsecData;
begin
  Result := LineInTri(A, AData, ACheckScale);
end;

function TGPlane.LineInCircle(const A: TGLine; const ACheckScale: Single): Boolean;
var
  AData: TLineIntsecData;
begin
  Result := LineInCircle(A, AData, ACheckScale);
end;

constructor TGPlane.Create(const SV, DVS, DVT: TGVector3);
begin
  Self.SV := SV;
  Self.DVS := DVS;
  Self.DVT := DVT;
end;

function TGPlane.Normal: TGVector3;
begin
  Result := DVS.Cross(DVT).Normalize;
end;

function TGPlane.AngleTo(const APlane: TGPlane): Single;
begin
  Result := Normal.AngleTo(APlane.Normal);
end;

{ TSphere }

function TSphere.GetPoint(const D: TGDirection; const AScale: Single): TGVector3;
begin
  Result := Location.Matrix * D.ToVector(FScale * AScale).ToVec4;
end;

function TSphere.LineIntsec(ALine: TGLine): Boolean;
var
  LineData: TGLine.TOrthoProjData;
begin
  ALine.SV := Location.Matrix * ALine.SV.ToVec4;
  ALine.DV := Location.RotMatrix * ALine.DV;
  ALine.OrthoProj(Location.RealPosition, LineData);
  Result := LineData.Height <= 1;
end;

function TSphere.LineIntsec(ALine: TGLine; out AData: TLineIntsecData): Boolean;
var
  LineData: TGLine.TOrthoProjData;
  DistanceOffset: Single;
  ALineTransformed: TGLine;
begin
  ALineTransformed.SV := Location.InvMatrix * ALine.SV.ToVec4;
  ALineTransformed.DV := Location.InvRotMatrix * ALine.DV;
  ALineTransformed.OrthoProj(Origin, LineData);
  Result := LineData.Height <= 1;

  AData.Height := Location.RealPosition.DistanceTo(ALine.GetPoint(LineData.Distance));
  if Result then
  begin
    DistanceOffset := sqrt(1 - sqr(LineData.Height)) / ALineTransformed.DV.Length;
    with AData.NearData do
    begin
      Distance := LineData.Distance - DistanceOffset;
      Point := ALine.GetPoint(Distance);
      Direction := TGDirection.FromVector(Location.RotMatrix * Location.RealPosition.VectorTo(Point));
    end;
    with AData.FarData do
    begin
      Distance := LineData.Distance + DistanceOffset;
      Point := ALine.GetPoint(Distance);
      Direction := TGDirection.FromVector(Location.RotMatrix * Location.RealPosition.VectorTo(Point));
    end;
  end;
end;

constructor TSphere.Create;
begin
  Create(UVecXYZ);
end;

constructor TSphere.Create(AScale: TGVector3);
begin
  FLocation := TLocation.Create;
  FScale := AScale;
end;

destructor TSphere.Destroy;
begin
  FLocation.Free;
  inherited;
end;

{ TGEllipse }

function TGEllipse.GetPoint(S: Single): TGVector;
begin
  Result := SV + Sin(S) * DVS + Cos(S) * DVT;
end;

class function TGEllipse.NewS(SV, DVS, DVT: TGVector): TGEllipse;
begin
  Result.SV := SV;
  Result.FDVT := DVT;
  Result.DVS := DVS;
end;

class function TGEllipse.NewT(SV, DVS, DVT: TGVector): TGEllipse;
begin
  Result.SV := SV;
  Result.FDVS := DVS;
  Result.DVT := DVT;
end;

procedure TGEllipse.SetDVS(const Value: TGVector);
var
  N: TGVector;
begin
  FDVS := Value;
  N := DVS.Cross(DVT);
  FDVT := N.Cross(DVS) / DVS.Dot(DVS);
end;

procedure TGEllipse.SetDVT(const Value: TGVector);
var
  N: TGVector;
begin
  FDVT := Value;
  N := DVT.Cross(DVS);
  FDVS := N.Cross(DVT) / DVT.Dot(DVT);
end;

{ TGDirection }

function TGDirection.ToVector: TGVector;
begin
  Result := TGVector.Create(Sin(T) * Cos(P), Sin(P), Cos(T) * Cos(P));
end;

constructor TGDirection.Create(const T, P: Single);
begin
  Self.T := T / 180 * Pi;
  Self.P := P / 180 * Pi;
end;

function TGDirection.GetPitchAngle: Single;
begin
  Result := P * 180 / Pi;
end;

function TGDirection.GetTurnAngle: Single;
begin
  Result := T * 180 / Pi;
end;

procedure TGDirection.SetPitchAngle(AValue: Single);
begin
  AValue := AValue / 180 * Pi;
  if P = AValue then
    Exit;
  P := AValue;
end;

procedure TGDirection.SetTurnAngle(AValue: Single);
begin
  AValue := AValue / 180 * Pi;
  if T = AValue then
    Exit;
  T := AValue;
end;

class function TGDirection.FromVector(ADirection: TGVector3): TGDirection;
begin
  if ADirection = Origin then
  begin
    Result.P := NaN;
    Result.T := NaN;
    Exit;
  end;
  ADirection := ADirection.Normalize;
  Result.P := ArcSin(ADirection.Y);
  Result.T := Sqrt(1 - Sqr(ADirection.Y));
  if Result.T <> 0 then
  begin
    Result.T := EnsureRange(ADirection.X / Result.T, -1, +1);
    Result.T := ArcSin(Result.T);
    if ADirection.Z < 0 then
      Result.T := Pi - Result.T;
  end;
end;

function TGDirection.Pitch(const Angle: Single): TGDirection;
begin
  Result.T := T;
  Result.P := P + Angle / 180 * Pi;
end;

function TGDirection.ToVector(const Scale: Single): TGVector3;
begin
  Result := TGVector.Create(Sin(T) * Cos(P), Sin(P), Cos(T) * Cos(P)) * Scale;
end;

function TGDirection.ToVector(const Scale: TGVector3): TGVector3;
begin
  Result := TGVector.Create(Sin(T) * Cos(P), Sin(P), Cos(T) * Cos(P)) * Scale;
end;

function TGDirection.Turn(const Angle: Single): TGDirection;
begin
  Result.T := T + Angle / 180 * Pi;
  Result.P := P;
end;

function TGDirection.TurnPitch(const TAngle, PAngle: Single): TGDirection;
begin
  Result.T := T + TAngle / 180 * Pi;
  Result.P := P + PAngle / 180 * Pi;
end;

{ TGVector }

class operator TGVector.Add(const A, B: TGVector): TGVector;
begin
  Result.X := A.X + B.X;
  Result.Y := A.Y + B.Y;
  Result.Z := A.Z + B.Z;
  Result.W := A.W;
end;

function TGVector.Cross(const A: TGVector): TGVector;
begin
  if (Self = Origin) or (A = Origin) then
    Result := Origin
  else
  begin
    Result.X := Y * A.Z - Z * A.Y;
    Result.Y := Z * A.X - X * A.Z;
    Result.Z := X * A.Y - Y * A.X;
    Result.W := Self.W;
  end;
end;

function TGVector.DistanceTo(const A: TGVector): Single;
begin
  Result := VectorTo(A).Length;
end;

class operator TGVector.Divide(const A: TGVector; const V: Single): TGVector;
begin
  Result.X := A.X / V;
  Result.Y := A.Y / V;
  Result.Z := A.Z / V;
  Result.W := A.W;
end;

class operator TGVector.Divide(const V: Single; const A: TGVector): TGVector;
begin
  Result.X := V / A.X;
  Result.Y := V / A.Y;
  Result.Z := V / A.Z;
  Result.W := A.W;
end;

class operator TGVector.Divide(const A, B: TGVector): TGVector;
begin
  Result.X := A.X / B.X;
  Result.Y := A.Y / B.Y;
  Result.Z := A.Z / B.Z;
  Result.W := A.W;
end;

class operator TGVector.Positive(const A: TGVector): TGVector;
begin
  Result := A; // so hardcore...
end;

function TGVector.Dot(const A: TGVector): Single;
begin
  Result := X * A.X + Y * A.Y + Z * A.Z;
end;

class operator TGVector.Equal(const A, B: TGVector): Boolean;
begin
  Result := (A.X = B.X) and (A.Y = B.Y) and (A.Z = B.Z);
end;

function TGVector.VectorTo(const A: TGVector): TGVector;
begin
  Result := A - Self;
end;

function TGVector.Length: Single;
begin
  Result := Sqrt(SqrDot);
end;

class operator TGVector.Multiply(const A, B: TGVector): TGVector;
begin
  Result.X := A.X * B.X;
  Result.Y := A.Y * B.Y;
  Result.Z := A.Z * B.Z;
  Result.W := A.W;
end;

class operator TGVector.Multiply(const A: TMatrix4; const B: TGVector): TGVector;
begin
  Result.X := A[0, 0] * B.X + A[1, 0] * B.Y + A[2, 0] * B.Z + A[3, 0] * B.W;
  Result.Y := A[0, 1] * B.X + A[1, 1] * B.Y + A[2, 1] * B.Z + A[3, 1] * B.W;
  Result.Z := A[0, 2] * B.X + A[1, 2] * B.Y + A[2, 2] * B.Z + A[3, 2] * B.W;
  Result.W := A[0, 3] * B.X + A[1, 3] * B.Y + A[2, 3] * B.Z + A[3, 3] * B.W;
end;

class operator TGVector.Multiply(const B: TGVector; const A: TMatrix4): TGVector;
begin
  Result.X := A[0, 0] * B.X + A[0, 1] * B.Y + A[0, 2] * B.Z + A[0, 3] * B.W;
  Result.Y := A[1, 0] * B.X + A[1, 1] * B.Y + A[1, 2] * B.Z + A[1, 3] * B.W;
  Result.Z := A[2, 0] * B.X + A[2, 1] * B.Y + A[2, 2] * B.Z + A[2, 3] * B.W;
  Result.W := A[3, 0] * B.X + A[3, 1] * B.Y + A[3, 2] * B.Z + A[3, 3] * B.W;
end;

class operator TGVector.Multiply(const A: TGVector; const V: Single): TGVector;
begin
  Result.X := A.X * V;
  Result.Y := A.Y * V;
  Result.Z := A.Z * V;
  Result.W := A.W;
end;

class operator TGVector.Multiply(const V: Single; const A: TGVector): TGVector;
begin
  Result := A * V;
end;

class operator TGVector.Negative(const A: TGVector): TGVector;
begin
  Result.X := -A.X;
  Result.Y := -A.Y;
  Result.Z := -A.Z;
  Result.W := A.W;
end;

constructor TGVector.Create(const X, Y, Z: Single; const W: Single);
begin
  Self.X := X;
  Self.Y := Y;
  Self.Z := Z;
  Self.W := W;
end;

function TGVector.Normalize: TGVector;
begin
  Result := Self / Self.Length;
end;

function TGVector.Abs: TGVector;
begin
  Result.X := System.Abs(X);
  Result.Y := System.Abs(Y);
  Result.Z := System.Abs(Z);
  Result.W := W;
end;

function TGVector.GetCosAngle(const A: TGVector): Single;
begin
  Result := EnsureRange(Dot(A) / (Length * A.Length), -1, 1);
end;

function TGVector.AngleTo(const A: TGVector): Single;
begin
  Result := ArcCos(GetCosAngle(A)) * 180 / Pi;
end;

function TGVector.Floor: TGVector;
begin
  Result.X := Math.Floor(X);
  Result.Y := Math.Floor(Y);
  Result.Z := Math.Floor(Z);
end;

function TGVector.Ceil: TGVector;
begin
  Result.X := Math.Ceil(X);
  Result.Y := Math.Ceil(Y);
  Result.Z := Math.Ceil(Z);
end;

function TGVector.ToString: String;
begin
  Result := Self;
end;

class operator TGVector.NotEqual(const A, B: TGVector): Boolean;
begin
  Result := (A.X <> B.X) or (A.Y <> B.Y) or (A.Z <> B.Z);
end;

class operator TGVector.LessThan(const A, B: TGVector): Boolean;
begin
  Result := (A.X < B.X) and (A.Y < B.Y) and (A.Z < B.Z);
end;

class operator TGVector.LessThanOrEqual(const A, B: TGVector): Boolean;
begin
  Result := (A.X <= B.X) and (A.Y <= B.Y) and (A.Z <= B.Z);
end;

class operator TGVector.GreaterThan(const A, B: TGVector): Boolean;
begin
  Result := (A.X > B.X) and (A.Y > B.Y) and (A.Z > B.Z);
end;

class operator TGVector.GreaterThanOrEqual(const A, B: TGVector): Boolean;
begin
  Result := (A.X >= B.X) and (A.Y >= B.Y) and (A.Z >= B.Z);
end;

class operator TGVector.Implicit(const A: TGVector): String;
begin
  Result := Format('[%f|%f|%f]', [A.X, A.Y, A.Z]);
end;

function TGVector.Rotate(A: TGVector; Angle: Single): TGVector;
var
  UX, UZ: TGVector;
  VX, VY: Single;
begin
  Angle := Angle * Pi / 180;

  A := A.Normalize;

  UZ := Self.Cross(A);
  UX := A.Cross(UZ);

  VX := UX.Dot(Self) / UX.Dot(UX);
  VY := A.Dot(Self) / A.Dot(A);

  Result := Cos(Angle) * VX * UX + VY * A + Sin(Angle) * VX * UZ;
end;

class operator TGVector.Subtract(const A, B: TGVector): TGVector;
begin
  Result.X := A.X - B.X;
  Result.Y := A.Y - B.Y;
  Result.Z := A.Z - B.Z;
  Result.W := A.W;
end;

class operator TGVector.Add(const A: TGVector; const V: Single): TGVector;
begin
  Result.X := A.X + V;
  Result.Y := A.Y + V;
  Result.Z := A.Z + V;
  Result.W := A.W;
end;

class operator TGVector.Subtract(const A: TGVector; const V: Single): TGVector;
begin
  Result.X := A.X - V;
  Result.Y := A.Y - V;
  Result.Z := A.Z - V;
  Result.W := A.W;
end;

function TGVector.SqrDot: Single;
begin
  Result := sqr(X) + sqr(Y) + sqr(Z);
end;

end.
