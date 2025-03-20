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

    constructor Create(pVersaoDB: integer; pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pProcessLog: IProcessLog;
      pOutput: IOutput); override;

    function Funcionou: boolean; override;
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, System.StrUtils, Sis.DB.Updater.Constants_u,
  Sis.Types.strings_u, Sis.Win.Utils_u, Sis.UI.IO.Files;

{ TComandoFBCreateOrAlterPackage }

constructor TComandoFBCreateOrAlterPackage.Create(pVersaoDB: integer;
  pDBConnection: IDBConnection; pUpdaterOperations: IDBUpdaterOperations;
  pProcessLog: IProcessLog; pOutput: IOutput);
begin
  inherited Create(pVersaoDB, pDBConnection, pUpdaterOperations,
    pProcessLog, pOutput);
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
  sNomeArq: string;
begin
  DBUpdaterOperations.PackagePegarCodigo(FPackageName, sCabec, sBody);

  Result := FCabecLinhasSL.Text = sCabec;
  if not Result then
  begin
    UltimoErro :=
      'TComandoFBCreateOrAlterPackage, Erro ao criar o cabecalho da package ' +
      FPackageName;
    sNomeArq := PastaTmp + ClassName + ' ' + FPackageName + ' sCabec.txt';
    EscreverArquivo(sCabec, sNomeArq);
    sNomeArq := PastaTmp + ClassName + ' ' + FPackageName + ' CabecLinhas.txt';
    EscreverArquivo(FCabecLinhasSL.Text, sNomeArq);
    Exit;
  end;

  Result := FBodyLinhasSL.Text = sBody;
  if not Result then
  begin
    UltimoErro :=
      'TComandoFBCreateOrAlterPackage, Erro ao criar o codigo da package ' +
      FPackageName;
    sNomeArq := PastaTmp + ClassName + ' ' + FPackageName + ' sBody.txt';
    EscreverArquivo(sBody, sNomeArq);
    sNomeArq := PastaTmp + ClassName + ' ' + FPackageName + ' BodyLinhas.txt';
    EscreverArquivo(FBodyLinhasSL.Text, sNomeArq);
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
  UltimoIndex: integer;
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
    begin
      if not bPegandoCodigo then
        Continue;
    end;

    if bPegandoCodigo then
    begin
      if Trim(sLinha) = SYNTAX_FIM then
      begin
        bPegandoCodigo := False;
        break;
      end;
      FPackageDefSL.Add(sLinha);

      if LeftStr(sLinha, 23) = 'CREATE OR ALTER PACKAGE' then
      begin
        bPegandoCabec := True;
      end
      else if LeftStr(sLinha, 21) = 'RECREATE PACKAGE BODY' then
      begin
        UltimoIndex := FPackageDefSL.Count - 1;
        FPackageDefSL.Insert(UltimoIndex, '');
        bPegandoBody := True;
      end;

      if bPegandoCabec then
      begin
        FCabecLinhasSL.Add(sLinha);
        if Trim(sLinha) = 'END^' then
        begin
          bPegandoCabec := False
        end;
      end
      else if bPegandoBody then
      begin
        FBodyLinhasSL.Add(sLinha);
        if Trim(sLinha) = 'END^' then
        begin
          bPegandoBody := False
        end;
      end;

    end
    else if StrSemStr(sLinha) = SYNTAX_FIREBIRD_INI then
    begin
      bPegandoCodigo := True;
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
