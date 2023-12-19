unit Sis.DB.Updater.Comando.FB.CreateOrAlterPackage_u;

interface

uses System.Classes, Sis.DB.Updater.Comando.FB_u, Sis.DB.DBTypes,
  Sis.DB.Updater.Operations, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output;

type
  TComandoFBCreateOrAlterPackage = class(TComandoFB)
  private
    FPackageName: string;
    FPackageDefSL: TStringList;

    FCabecLinhasSL: TStringList;
    FBodyLinhasSL: TStringList;
  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string; override;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); override;
    function GetAsSql: string; override;
    constructor Create(pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
      pOutput: IOutput);
    function Funcionou: boolean; override;
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, System.StrUtils, Sis.DB.Updater.Constants_u,
  Sis.Types.strings_u;

{ TComandoFBCreateOrAlterPackage }

constructor TComandoFBCreateOrAlterPackage.Create(pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
  pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pProcessLog, pOutput);
  FPackageDefSL := TStringList.Create;
  FCabecLinhasSL := TStringList.Create;
  FBodyLinhasSL := TStringList.Create;

  FCabecLinhasSL.LineBreak := #$A;
  FBodyLinhasSL.LineBreak := #$A;
end;

destructor TComandoFBCreateOrAlterPackage.Destroy;
begin
  FPackageDefSL.Free;
  FCabecLinhasSL.Free;
  FBodyLinhasSL.Free;
  inherited;
end;

function TComandoFBCreateOrAlterPackage.Funcionou: boolean;
var
  sCabec: string;
  sBody: string;
begin
  DBUpdaterOperations.PackagePegarCodigo(FPackageName, sCabec, sBody);

  // SetClipboardText(FCabecLinhasSL.Text);
  // SetClipboardText(sCabec);
  Result := FCabecLinhasSL.Text = sCabec;
  if not Result then
  begin
    UltimoErro :=
      'TComandoFBCreateOrAlterPackage, Erro ao criar o cabecalho da package ' +
      FPackageName;
    Exit;
  end;

  // SetClipboardText(FBodyLinhasSL.Text);
  // SetClipboardText(sBody);

  Result := FBodyLinhasSL.Text = sBody;
  if not Result then
  begin
    UltimoErro :=
      'TComandoFBCreateOrAlterPackage, Erro ao criar o codigo da package ' +
      FPackageName;
    Exit;
  end;
end;

function TComandoFBCreateOrAlterPackage.GetAsSql: string;
var
  sCabec: string;
  sBody: string;
begin
  Result := '';

  DBUpdaterOperations.PackagePegarCodigo(FPackageName, sCabec, sBody);
  {
    SetClipboardText(
    'sCabec'#13#10+sCabec+#13#10#13#10+
    'sBody'#13#10+sBody+#13#10#13#10+
    'FCabecLinhasSL'#13#10+ FCabecLinhasSL.Text+#13#10#13#10+
    'FBodyLinhasSL'#13#10+ FBodyLinhasSL.Text+#13#10#13#10
    ); }

  if (FCabecLinhasSL.Text = sCabec) and (FBodyLinhasSL.Text = sBody) then
    Exit;

  Result := FPackageDefSL.Text;

  if Result = '' then
    Exit;

  Result := #13#10 + '/*******'#13#10 + '*'#13#10 + '* ' + GetAsText + #13#10 +
    '*'#13#10 + '*******/'#13#10 + Result;
end;

function TComandoFBCreateOrAlterPackage.GetAsText: string;
begin
  Result := 'PACKAGE ' + FPackageName;
end;

procedure TComandoFBCreateOrAlterPackage.PegarLinhas(var piLin: integer;
  pSL: TStrings);
var
  sLinha: string;
  bPegandoCodigo: boolean;
  bPegandoCabec: boolean;
  bPegandoBody: boolean;
  sObjetoNome: string;
begin
  bPegandoCodigo := False;
  bPegandoCabec := False;
  bPegandoBody := False;

  FPackageDefSL.Clear;
  while piLin < pSL.Count - 1 do
  begin
    inc(piLin);
    sLinha := pSL[piLin];
    if Trim(sLinha) = '' then
      Continue;

    if bPegandoCodigo then
    begin
      if sLinha = SYNTAX_FIM then
      begin
        bPegandoCodigo := False;
        break;
      end;
      FPackageDefSL.Add(sLinha);

      if LeftStr(sLinha, 23) = 'CREATE OR ALTER PACKAGE' then
      begin
        bPegandoCabec := true;
      end
      else if LeftStr(sLinha, 21) = 'RECREATE PACKAGE BODY' then
      begin
        FPackageDefSL.Add('');
        bPegandoBody := true;
      end;

      if bPegandoCabec then
      begin
        FCabecLinhasSL.Add(sLinha);
        if sLinha = 'END^' then
        begin
          bPegandoCabec := False
        end;
      end
      else if bPegandoBody then
      begin
        FBodyLinhasSL.Add(sLinha);
        if sLinha = 'END^' then
        begin
          bPegandoBody := False
        end;
      end;

    end
    else if sLinha = SYNTAX_FIREBIRD_INI then
    begin
      bPegandoCodigo := true;
    end
    else if Pos(DBATUALIZ_OBJETO_NOME_CHAVE + '=', sLinha) = 1 then
    begin
      sObjetoNome := StrApos(sLinha, '=');
      PegarObjeto(sObjetoNome);
    end;
  end;

  if FCabecLinhasSL.Count > 3 then
  begin
    FCabecLinhasSL.Delete(0);
    FCabecLinhasSL.Delete(0);
    FCabecLinhasSL[FCabecLinhasSL.Count - 1] := 'END';
  end;

  if FBodyLinhasSL.Count > 3 then
  begin
    FBodyLinhasSL.Delete(0);
    FBodyLinhasSL.Delete(0);
    FBodyLinhasSL[FBodyLinhasSL.Count - 1] := 'END';
  end;
end;

procedure TComandoFBCreateOrAlterPackage.PegarObjeto(pNome: string);
begin
  inherited;
  FPackageName := pNome;
end;

end.
