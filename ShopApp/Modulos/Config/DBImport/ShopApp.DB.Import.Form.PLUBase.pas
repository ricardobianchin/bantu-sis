unit ShopApp.DB.Import.Form.PLUBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.DB.Import.Form_u, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, App.AppObj, System.Actions, Vcl.ActnList, Vcl.Buttons,
  Sis.UI.IO.Output, Sis.DB.DBTypes, Sis.UI.IO.Output.ProcessLog, Sis.Usuario,
  Sis.UI.Controls.Files.FileSelectLabeledEdit.Frame, Vcl.ComCtrls;

type
  TShopDBImportFormPLUBase = class(TDBImportForm)
    MoldeFileSelectPanel: TPanel;
    procedure ExecuteAction_AppDBImportExecute(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FNomeArq: string;
    FLinhaAtual: string;
    FFileSelectFrame: TFileSelectLabeledEditFrame;
    FLinhasSL: TStringList;

    iIndexErro: integer;
    iProdId: integer;

    sDescr, sDescrRed, sNCM: string;

    iProdTipoId: integer;
    sProdTipoDescr: string;
    sBarCod: string;
    cCusto: Currency;
    cPreco: Currency;

    ProdIdSL: TStringList;
    DescrSL: TStringList;
    DescrRedSL: TStringList;
    ProdFabrSL: TStringList;
    ProdTipoSL: TStringList;
    ProdUnidSL: TStringList;
    ProdIcmsSL: TStringList;

    procedure GravarImportProdTipo;
    procedure GravarTabExtrangeira(pNomeTab, pDescrVal: string; pValoresSL: TStrings);

    procedure LeiaLinhaAtual;
    procedure GravarLinhaAtual;
    function JaTemDescr(pDescr: string): boolean;
    function JaTemDescrRed(pDescr: string): boolean;
  protected
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pUsuario: IUsuario;
      pProcessLog: IProcessLog = nil);
  end;

var
  ShopDBImportFormPLUBase: TShopDBImportFormPLUBase;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, System.StrUtils, Sis.Types.strings_u,
  Sis.Types.Integers, Sis.Types.Floats, Sis.Win.Utils_u;

{ TShopDBImportFormPLUBase }

constructor TShopDBImportFormPLUBase.Create(AOwner: TComponent;
  pAppObj: IAppObj; pUsuario: IUsuario; pProcessLog: IProcessLog = nil);
begin
  inherited;
  FFileSelectFrame := TFileSelectLabeledEditFrame.Create(TopoPanel);
  FFileSelectFrame.EditCaption := 'Arquivo PLUBASE.TXT';
  PegueFormatoDe(FFileSelectFrame, MoldeFileSelectPanel);
  iIndexErro := 0;
end;

procedure TShopDBImportFormPLUBase.ExecuteAction_AppDBImportExecute
  (Sender: TObject);
var
  bResultado: boolean;
  iLinhaAtual: integer;
  sSql: string;
begin
  inherited;
  StatusOutput.Exibir('Inicio');
  try
    FNomeArq := FFileSelectFrame.NomeArq;

    bResultado := FNomeArq <> '';
    if not bResultado then
    begin
      StatusOutput.ExibirPausa('Erro: Nome do Arquivo e´ obrigatorio',
        TMsgDlgType.mtError);
      Exit;
    end;

    bResultado := FileExists(FNomeArq);
    if not bResultado then
    begin
      StatusOutput.ExibirPausa('Erro: Arquivo nao existe: [' + FNomeArq + ']',
        TMsgDlgType.mtError);
      Exit;
    end;

    FLinhasSL := TStringList.Create;
    ProdIdSL := TStringList.Create;
    DescrSL := TStringList.Create;
    DescrRedSL := TStringList.Create;
    ProdFabrSL := TStringList.Create;
    ProdTipoSL := TStringList.Create;
    ProdUnidSL := TStringList.Create;
    ProdIcmsSL := TStringList.Create;

    ProdFabrSL.Add('NAO INDICADO');
    ProdTipoSL.Add('NAO INDICADO');
    ProdUnidSL.Add('NAO INDICADO');
    ProdIcmsSL.Add('NAO INDICADO');


    begin // especifico plubase
    ProdFabrSL.Add('PADRAO');
    GravarTabExtrangeira('FABR', 'PADRAO', ProdFabrSL);
    end;

    DestinoDBConnection.Abrir;
    ProgressBar1.Visible := true;
    try
      bResultado := ZereDados(DestinoDBConnection);
      if not bResultado then
        Exit;

      FLinhasSL.LoadFromFile(FNomeArq);
      FLinhasSL.Delete(0);
      StatusOutput.Exibir('Qtd linhas: ' + FLinhasSL.Count.ToString);
      ProgressBar1.Max := FLinhasSL.Count - 1;
      for iLinhaAtual := 0 to FLinhasSL.Count - 1 do
      begin
        ProgressBar1.Position := iLinhaAtual;
        FLinhaAtual := StrSemAcento(FLinhasSL[iLinhaAtual]);
        LeiaLinhaAtual;
        GravarLinhaAtual;
      end;
    finally
      DestinoDBConnection.Fechar;
      FLinhasSL.Free;
      ProdIdSL.Free;
      DescrSL.Free;
      DescrRedSL.Free;

      ProdFabrSL.Free;
      ProdTipoSL.Free;
      ProdUnidSL.Free;
      ProdIcmsSL.Free;

      ProgressBar1.Visible := False;
    end;

  finally
    StatusOutput.Exibir('Fim');
    StatusOutput.Exibir('');
  end;
end;

procedure TShopDBImportFormPLUBase.GravarImportProdTipo;
var
  sSql: string;
begin
  iProdTipoId := ProdTipoSL.IndexOf(sProdTipoDescr);
  if iProdTipoId = -1 then
  begin
    ProdTipoSL.Add(sProdTipoDescr);
    iProdTipoId := ProdTipoSL.Count - 1;

    sSql := 'EXECUTE PROCEDURE IMPORT_PROD_TIPO_PA.GARANTIR_ID_DESCR('
      + QuotedStr(sProdTipoDescr) + ', ' + iProdTipoId.ToString
      + ');';

    DestinoDBConnection.ExecuteSQL(sSql);
  end;
end;

procedure TShopDBImportFormPLUBase.GravarLinhaAtual;
begin
  GravarImportProdTipo;
  GravarTabExtrangeira('PROD_TIPO', sProdTipoDescr, ProdTipoSL);
end;

procedure TShopDBImportFormPLUBase.GravarTabExtrangeira(pNomeTab, pDescrVal: string; pValoresSL: TStrings);
var
  sSql: string;
  iId: integer;
begin
  iProdTipoId := ProdTipoSL.IndexOf(pDescrVal);
  if iProdTipoId = -1 then
  begin
    pValoresSL.Add(pDescrVal);
    iId := pValoresSL.Count - 1;

    sSql := 'EXECUTE PROCEDURE IMPORT_'+pNomeTab+'_PA.GARANTIR_ID_DESCR('
      + QuotedStr(pDescrVal) + ', ' + iId.ToString
      + ');';

    DestinoDBConnection.ExecuteSQL(sSql);
  end;
end;

function TShopDBImportFormPLUBase.JaTemDescr(pDescr: string): boolean;
begin
  Result := DescrSL.IndexOf(pDescr) > -1;
end;

function TShopDBImportFormPLUBase.JaTemDescrRed(pDescr: string): boolean;
begin
  Result := DescrRedSL.IndexOf(pDescr) > -1;
end;

procedure TShopDBImportFormPLUBase.LeiaLinhaAtual;
var
  s: string;
begin
  s := Copy(FLinhaAtual, 1, 7);
  iProdId := StrToInt(s);

  // descr
  s := StrSemCharRepetido(Copy(FLinhaAtual, 21, 40));
  if JaTemDescr(s) then
  begin
    inc(iIndexErro);
    while Length(s + ' _ERR' + IntToStr(iIndexErro)) > 120 do
    begin
      s := Trim(StrDeleteNoFim(s, 1));
    end;
    s := s + '_ERR' + IntToStr(iIndexErro);
  end;
  sDescr := s;
  DescrSL.Add(sDescr);

  // descr red
  s := StrSemCharRepetido(LeftStr(sDescr, 29));
  if JaTemDescrRed(s) then
  begin
    inc(iIndexErro);
    while Length(s + ' _ERR' + IntToStr(iIndexErro)) > 29 do
    begin
      s := Trim(StrDeleteNoFim(s, 1));
    end;
    s := s + ' _ERR' + IntToStr(iIndexErro);
  end;
  sDescrRed := s;
  DescrRedSL.Add(sDescrRed);

  sNCM := Trim(Copy(FLinhaAtual, 168, 8));

  sProdTipoDescr := 'SETOR ' + Copy(FLinhaAtual, 85, 2);

  sBarCod := StrToIntStr(Copy(FLinhaAtual, 8, 13));

  if sBarCod = '0' then
    sBarCod := '';

  // custo
  s := Copy(FLinhaAtual, 138, 10);
  Insert('.', s, 9);
  cCusto := StrToCurrency(s);

  if cCusto = 0 then
    cCusto := 0.01;

  // preco
  s := Copy(FLinhaAtual, 61, 10);
  Insert('.', s, 9);
  cPreco := StrToCurrency(s);

  if cPreco < 0.01 then
    cPreco := 0.01;

  {
    s :=
    sDescr, sDescrRed, sNCM: string;
    ProdCodStr:=substr(Linha, 1, 7);
  }
end;

procedure TShopDBImportFormPLUBase.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  // {$IFDEF DEBUG}
  // FFileSelectFrame.NomeArq := 'X:\Doc\Bantu\Clientes\Daros\PLUBASE.TXT';
  // ExecuteAction_AppDBImport.Execute;
  // {$ENDIF}
end;

end.
