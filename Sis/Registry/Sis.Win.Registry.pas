unit Sis.Win.Registry;

interface

uses System.Win.Registry, Winapi.Windows;

type
  TRegistryView = (rvDefault, rvRegistry64, rvRegistry32);

function ReadRegStr(const Root: HKEY; const Key, Name: string;
  const View: TRegistryView = rvDefault): string;

(*
  {$EXTERNALSYM HKEY_CLASSES_ROOT}
  HKEY_CLASSES_ROOT     = HKEY(Integer($80000000));
  {$EXTERNALSYM HKEY_CURRENT_USER}
  HKEY_CURRENT_USER     = HKEY(Integer($80000001));
  {$EXTERNALSYM HKEY_LOCAL_MACHINE}
  HKEY_LOCAL_MACHINE    = HKEY(Integer($80000002));
  {$EXTERNALSYM HKEY_USERS}
  HKEY_USERS            = HKEY(Integer($80000003));
  {$EXTERNALSYM HKEY_PERFORMANCE_DATA}
  HKEY_PERFORMANCE_DATA = HKEY(Integer($80000004));
  {$EXTERNALSYM HKEY_CURRENT_CONFIG}
  HKEY_CURRENT_CONFIG   = HKEY(Integer($80000005));
  {$EXTERNALSYM HKEY_DYN_DATA}
  HKEY_DYN_DATA         = HKEY(Integer($80000006));
*)

implementation

function RegistryViewAccessFlag(View: TRegistryView): LongWord;
begin
  case View of
    rvDefault:
      Result := 0;
    rvRegistry64:
      Result := KEY_WOW64_64KEY;
    //rvRegistry32:
    else  Result := KEY_WOW64_32KEY;
  end;
end;

function ReadRegStr(const Root: HKEY; const Key, Name: string;
  const View: TRegistryView = rvDefault): string;
var
  registry: TRegistry;
begin
  Result := '';

  registry := TRegistry.Create(KEY_READ or RegistryViewAccessFlag(View));
  try
    registry.RootKey := Root;

    if not registry.OpenKey(Key, false) then
      exit;

    if not registry.ValueExists(Name) then
      exit;

    {
      if not registry.OpenKey(Key, false) then
      raise ERegistryException.CreateFmt('Key not found: %s', [Key]);
      if not registry.ValueExists(Name) then
      raise ERegistryException.CreateFmt('Name not found: %s\%s', [Key, Name]);
    }
    Result := registry.ReadString(Name);
    // will raise exception in case of failure
  finally
    registry.Free;
  end;
end;

end.
