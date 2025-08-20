unit App.UI.Form.Bas.Princ.Sessoes.AtalhosGarantidor_u;

interface

uses Sis.Sis.Executavel_u, App.UI.Form.Bas.Princ.Sessoes.AtalhosGarantidor,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog, System.Classes,
  Sis.Win.ShortCutCreator, App.AppInfo;

type
  TAtalhosGarantidor = class(TExecutavel, IAtalhosGarantidor)
  private
    FTermsSL: TStrings;
    FNomesArqExistentesSL: TStringList;
    FNomesArqDevemExistirSL: TStringList;
    FPastaDesktop: string;
    FExe, FStartIn: string;
    FShortCutCreator: IShortCutCreator;
    FAppInfo: IAppInfo;

    function SemTerms: Boolean;
    procedure InicializeSLs;
    procedure DeleteIguais;
  public
    constructor Create(pAppInfo: IAppInfo; pTermsSL: TStrings;
      pOutput: IOutput = nil; pProcessLog: IProcessLog = nil);
    destructor Destroy; override;

    function Execute: Boolean; override;
  end;

implementation

uses Sis.Win.Utils_u, Sis.UI.IO.Files, System.SysUtils, Sis.Types.TStrings_u,
  Sis.Win.Factory, Vcl.Dialogs;

{ TAtalhosGarantidor }

constructor TAtalhosGarantidor.Create(pAppInfo: IAppInfo; pTermsSL: TStrings;
  pOutput: IOutput; pProcessLog: IProcessLog);
begin
  inherited Create(pOutput, pProcessLog);
  pProcessLog.PegueLocal('TAtalhosGarantidor.Create');
  try
    FAppInfo := pAppInfo;
    FTermsSL := pTermsSL;
    FNomesArqExistentesSL := TStringList.Create;
    FNomesArqDevemExistirSL := TStringList.Create;

    FPastaDesktop := Sis.Win.Utils_u.GetPublicDesktopPath;
    ProcessLog.RegistreLog('FPastaDesktop=' + FPastaDesktop);

    FExe := ParamStr(0);
    FStartIn := GetPastaDoArquivo(FExe);

    InicializeSLs;
  finally
    pProcessLog.RetorneLocal;
  end;
end;

procedure TAtalhosGarantidor.DeleteIguais;
begin
  ProcessLog.PegueLocal('TAtalhosGarantidor.DeleteIguais');
  try
    ProcessLog.RegistreLog('vai DeleteItensIguais');
    Sis.Types.TStrings_u.DeleteItensIguais(FNomesArqExistentesSL,
      FNomesArqDevemExistirSL);
    ProcessLog.RegistreLog('DeleteItensIguais voltou');

    ProcessLog.RegistreLog('FNomesArqDevemExistirSL='#13#10 +
      FNomesArqDevemExistirSL.text + #13#10);

    ProcessLog.RegistreLog('FNomesArqExistentesSL='#13#10 +
      FNomesArqExistentesSL.text + #13#10);
  finally
    ProcessLog.RetorneLocal;
  end;
end;

destructor TAtalhosGarantidor.Destroy;
begin
  FNomesArqExistentesSL.Free;
  FNomesArqDevemExistirSL.Free;
  inherited;
end;

function TAtalhosGarantidor.Execute: Boolean;
var
  iQtdVoltas: integer;
  i: integer;
  sTermTit: string;
begin
  ProcessLog.PegueLocal('TAtalhosGarantidor.Execute');
  try
    Result := SemTerms;
    if Result then
      exit;

    iQtdVoltas := 0;
    repeat
      try
        ProcessLog.RegistreLog('Loop=' + iQtdVoltas.ToString);
        InicializeSLs;
        DeleteIguais;
        Sis.UI.IO.Files.ApagueArquivos(FPastaDesktop, FNomesArqExistentesSL);

        Result := FNomesArqDevemExistirSL.Count = 0;
        if Result then
        begin
          ProcessLog.RegistreLog('NomesArqDevemExistirSL.Count = 0, abortando');
          exit;
        end;

        case iQtdVoltas of
          0:
            begin
              FShortCutCreator := ShortCutCreatorCreate('Cria Atalho',
                FAppInfo.PastaComandos, FPastaDesktop, 'ps1', Output,
                ProcessLog);
            end;
          1:
            begin
              FShortCutCreator := ShortCutCreatorCreate('Cria Atalho',
                FAppInfo.PastaComandos, FPastaDesktop, 'bat', Output,
                ProcessLog);
            end;
        else
          begin
            ProcessLog.RegistreLog('Erro. O sistema não conseguiu criar atalhos no desktop');
            ShowMessage
              ('Erro. O sistema não conseguiu criar atalhos no desktop.'#13#10'O sistema será fechado');
            exit;
          end;
        end;

        for i := 0 to FNomesArqDevemExistirSL.Count - 1 do
        begin
          sTermTit := ExtractFileNameOnly(FNomesArqDevemExistirSL[i]);
          FShortCutCreator.AddScriptFor(sTermTit, FExe, sTermTit, FStartIn);
        end;

        ProcessLog.RegistreLog('FShortCutCreator.Execute');
        FShortCutCreator.Execute;
      finally
        inc(iQtdVoltas);
      end;
    until false;
  finally
    ProcessLog.RegistreLog('Terminou');
    ProcessLog.RetorneLocal;
  end;
end;

procedure TAtalhosGarantidor.InicializeSLs;
var
  i: integer;
begin
  ProcessLog.PegueLocal('TAtalhosGarantidor.InicializeSLs');
  try
    FNomesArqDevemExistirSL.Clear;
    for i := 0 to FTermsSL.Count - 1 do
    begin
      FNomesArqDevemExistirSL.Add(FTermsSL[i] + '.lnk');
    end;

    LeDiretorio(FPastaDesktop, FNomesArqExistentesSL, True, 'PDV*.lnk');

    ProcessLog.RegistreLog('FNomesArqDevemExistirSL='#13#10 +
      FNomesArqDevemExistirSL.text + #13#10);

    ProcessLog.RegistreLog('FNomesArqExistentesSL='#13#10 +
      FNomesArqExistentesSL.text + #13#10);
  finally
    ProcessLog.RetorneLocal;
  end;
end;

function TAtalhosGarantidor.SemTerms: Boolean;
begin
  Result := FTermsSL.Count = 0;
  if Result then
  begin
    ProcessLog.RegistreLog('FTermsSL.Count = 0, abortando');
    exit;
  end;

  ProcessLog.RegistreLog('terms com botao:'#13#10 + FTermsSL.text + #13#10);
end;

end.
