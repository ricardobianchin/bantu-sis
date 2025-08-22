unit Sis.Log_u;

interface

uses Sis.Log, System.Classes;

type
  TLog = class(TInterfacedObject, ILog)
  private
    FPastaLog: string;
    SL: TStringList;
    function GarantaDic(pNomeArq: string): string;
    procedure Inicie;
    function Comprima(pFrase, pNomeArq: string): string;
  public
    procedure Escreva(pFrase: string);
    constructor Create;
    destructor Destroy; override;

  end;

implementation

uses Sis_u, System.SysUtils, Sis.UI.IO.Files, Sis.Types.Utils_u,
  System.DateUtils;

{ TLog }

function TLog.Comprima(pFrase, pNomeArq: string): string;
var
  sNomeArqDic: string;
  i: integer;
begin
  sNomeArqDic := GarantaDic(pNomeArq);

  SL.loadfromfile(sNomeArqDic);
  i := SL.IndexOf(pFrase);
  if i = -1 then
  begin
    i := SL.Count;
    SL.Add(pFrase);
    SL.SaveToFile(sNomeArqDic);
  end;
  Result := '&'+i.ToString+';';
end;

constructor TLog.Create;
begin
  SL := TStringList.Create;
  Inicie;
end;

destructor TLog.Destroy;
begin
  SL.free;
  inherited;
end;

procedure TLog.Escreva(pFrase: string);
var
  dAgora: TDateTime;
  sAgora: string;
  dHoje: TDateTime;
  sNomeArq: string;
begin
  dAgora := Now;
  dHoje := Trunc(dAgora);

  sNomeArq := FPastaLog + 'Log Assist ' + DateToNomeArq(dHoje) + '.txt';

  sAgora := FormatDateTime('hh:nn:ss,zzz', dAgora);
  pFrase := StringReplace(pFrase, #13#10, ';', [TReplaceFlag.rfReplaceAll]);

  pFrase := Comprima(pFrase, sNomeArq);
  pFrase := sAgora + ';' + pFrase + sNOVA_LINHA;

  AdicioneAoArquivo(pFrase, sNomeArq);
end;

function TLog.GarantaDic(pNomeArq: string): string;
begin
  Result := ChangeFileExt(pNomeArq, '');
  Result := Result + '.dic.txt';
  if not FileExists(Result) then
  begin
    EscreverArquivo('', Result);
  end;
end;

procedure TLog.Inicie;
var
  dAgora: TDateTime;
  sAgora: string;
  dHoje: TDateTime;
  sMens: string;
  sNomeArq: string;
begin
  FPastaLog := sPastaTmp + 'Assist\';
  GarantaPasta(FPastaLog);

  dAgora := Now;
  dHoje := Trunc(dAgora);

  sNomeArq := FPastaLog + 'Log Assist ' + DateToNomeArq(dHoje) + '.txt';

  sAgora := FormatDateTime('dd/mm/yyyy hh:nn:ss,zzz', dAgora);
  sMens := '--------------------------------------------' + sNOVA_LINHA + sAgora
    + ';' + 'Inicio' + sNOVA_LINHA;

  AdicioneAoArquivo(sMens, sNomeArq);
end;

end.
