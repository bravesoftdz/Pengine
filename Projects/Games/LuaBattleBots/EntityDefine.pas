unit EntityDefine;

interface

uses
  VAOManager, LuaHeader, Math, LuaConf;

type

  { TEntity }

  TEntity = class(TVAOProxy)
  private
    FDead: Boolean;
    FHealth, FMaxHealth: Single;

    procedure SetHealth(Value: Single);
    procedure SetMaxHealth(Value: Single);
  protected

  public
    constructor Create(ASourceVAO: TVAO; AHealth: Single);
    destructor Destroy; override;

    procedure Update(ADeltaTime: Single); virtual;

    property Health: Single read FHealth write SetHealth;
    property MaxHealth: Single read FMaxHealth write SetMaxHealth;
    
    property Dead: Boolean read FDead;
  end;

  { TLuaEntity }

  TLuaEntity = class(TEntity)
  private
    FLua: TLuaState;

    class function GetSelf(L: TLuaState): TLuaEntity; static;

    class function LuaGetHealth(L: TLuaState): Integer; static; cdecl;
    class function LuaGetMaxHealth(L: TLuaState): Integer; static; cdecl;
  protected

  public
    constructor Create(ASourceVAO: TVAO; AHealth: Single);
    destructor Destroy; override;

    procedure Update(ADeltaTime: Single); override;
  end;

implementation

{ TEntity }

procedure TEntity.SetHealth(Value: Single);
begin
  Value := EnsureRange(Value, 0, FMaxHealth);
  if Value = FHealth then
    Exit;
  FHealth := Value;
end;

procedure TEntity.SetMaxHealth(Value: Single);
begin
  Value := Max(Value, 0);
  if Value = FMaxHealth then
    Exit;
  FMaxHealth := Value;
  Health := Min(Health, FMaxHealth);
end;

constructor TEntity.Create(ASourceVAO: TVAO; AHealth: Single);
begin
  inherited Create(ASourceVAO);
  FHealth := AHealth;
  FMaxHealth := AHealth;
end;

destructor TEntity.Destroy;
begin
  inherited;
end;

procedure TEntity.Update(ADeltaTime: Single);
begin

end;

{ TLuaEntity }

class function TLuaEntity.GetSelf(L: TLuaState): TLuaEntity;
begin
  Result := TLuaEntity(PPointer(L.GetExtraSpace)^);
end;

class function TLuaEntity.LuaGetHealth(L: TLuaState): Integer;
var
  Self: TLuaEntity;
begin
  Self := GetSelf(L);

  L.CheckEnd(1);
  L.PushNumber(Self.Health);

  Result := 1;
end;

class function TLuaEntity.LuaGetMaxHealth(L: TLuaState): Integer;
var
  Self: TLuaEntity;
begin
  Self := GetSelf(L);

  L.CheckEnd(1);
  L.PushNumber(Self.MaxHealth);

  Result := 1;
end;

constructor TLuaEntity.Create(ASourceVAO: TVAO; AHealth: Single);
begin
  inherited Create(ASourceVAO, AHealth);

  // Lua Init
  FLua := NewLuaState;
  PPointer(FLua.GetExtraSpace)^ := Self;

  // Base Lua Functions
  FLua.Register('getHealth', LuaGetHealth);
  FLua.Register('getMaxHealth', LuaGetMaxHealth);
end;

destructor TLuaEntity.Destroy;
begin
  FLua.Close;

  inherited;
end;

procedure TLuaEntity.Update(ADeltaTime: Single);
begin
  inherited;
end;

end.