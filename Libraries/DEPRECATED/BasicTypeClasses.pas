unit BasicTypeClasses;

interface

uses
  Classes, SysUtils;

type

  { TInteger }

  TInteger = class
  public
    Value: Integer;

    constructor Create(AValue: Integer = 0);

    class function Compare(A, B: TObject): Boolean; static;
  end;

  { TSingle }

  TSingle = class
  public
    Value: Single;

    constructor Create(AValue: Single = 0);

    class function Compare(A, B: TObject): Boolean; static;
  end;

  { TDouble }

  TDouble = class
  public
    Value: Double;

    constructor Create(AValue: Double = 0);

    class function Compare(A, B: TObject): Boolean; static;
  end;

  { TString }

  TString = class
  private
    function GetChar(I: Cardinal): Char;
    procedure SetChar(I: Cardinal; AValue: Char);

  public
    Text: String;

    constructor Create(AString: String = '');

    property Char[I: Cardinal]: Char read GetChar write SetChar; default;

    class function Compare(A, B: TObject): Boolean; static;
  end;

  { TBoolean }

  TBoolean = class
  public
    Value: Boolean;

    constructor Create(AValue: Boolean = False);
  end;

implementation

{ TSingle }

constructor TSingle.Create(AValue: Single);
begin
  Value := AValue;
end;

class function TSingle.Compare(A, B: TObject): Boolean;
begin
  Result := TSingle(A).Value > TSingle(B).Value;
end;

{ TDouble }

constructor TDouble.Create(AValue: Double);
begin
  Value := AValue;
end;

class function TDouble.Compare(A, B: TObject): Boolean;
begin
  Result := TDouble(A).Value > TDouble(B).Value;
end;

{ TBoolean }

constructor TBoolean.Create(AValue: Boolean = False);
begin
  Value := AValue;
end;

{ TInteger }

constructor TInteger.Create(AValue: Integer);
begin
  Value := AValue;
end;

class function TInteger.Compare(A, B: TObject): Boolean;
begin
  Result := TInteger(A).Value > TInteger(B).Value;
end;

{ TString }

function TString.GetChar(I: Cardinal): Char;
begin
  Result := Text[I + 1];
end;

procedure TString.SetChar(I: Cardinal; AValue: Char);
begin
  Text[I + 1] := AValue;
end;

class function TString.Compare(A, B: TObject): Boolean;
begin
  Result := TString(A).Text > TString(B).Text;
end;

constructor TString.Create(AString: String);
begin
  Text := AString;
end;

end.

