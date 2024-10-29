unit App.Pess.Ender.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, Data.DB, App.Pess.Ender.Controls.Frame_u,
  App.Pess.Ender.DBGrid.Frame_u, App.Pess.Ent, Sis.DB.DataSet.Utils,
  App.Pess.DBI, FireDAC.Comp.Client, App.AppObj, App.Pess.Utils,
  App.PessEnder.List, App.PessEnder, Sis.UI.IO.Output;

type
  TEnderFrame = class(TBasFrame)
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;
    FFDMemTable: TFDMemTable;
    FEnderControlsFrame: TEnderControlsFrame;
    FEnderDBGridFrame: TEnderDBGridFrame;
    FAppObj: IAppObj;
    FOkExecute: TNotifyEvent;
    FErroOutput: IOutput;

    function GetNomeArqTabViewEndereco: string;
    procedure EnderecoFDMemTableAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPessEnt: IPessEnt;
      pPessDBI: IPessDBI; pAppObj: IAppObj; pOkExecute: TNotifyEvent; pErroOutput: IOutput); reintroduce;
    procedure AjusteControles;
    procedure ControlesToEnt;
    procedure EntToControles;
    function DadosOk: boolean;
  end;

//var
//  EnderFrame: TEnderFrame;

implementation

{$R *.dfm}

uses App.Pess.Ent.Factory_u, Sis.Types.strings_u;
{ TEnderFrame }

procedure TEnderFrame.ControlesToEnt;
var
  iOrdem: integer;
  oEnder: IPessEnder;
  bm: TBookmark;
  Tab: TFDMemTable;
begin
  FEnderControlsFrame.ControlesToEnt;
  FEnderDBGridFrame.ControlesToEnt;

  Tab := FFDMemTable;

  while FPessEnt.PessEnderList.Count < (Tab.RecordCount) do
  begin
    oEnder := PessEnderCreate;
    FPessEnt.PessEnderList.Add(oEnder);
  end;

  bm := Tab.GetBookmark;
  Tab.First;
  try
    while not Tab.Eof do
    begin
      iOrdem := Tab.Fields[0].AsInteger;
      oEnder := FPessEnt.PessEnderList[iOrdem];
      oEnder.CEP := StrToOnlyDigit(Tab.Fields[7 { CEP } ].AsString);
      oEnder.UFSigla := Tab.Fields[6 { UF_SIGLA } ].AsString;

      oEnder.MunicipioNome :=Tab.Fields[5 { MUNICIPIO_NOME } ].AsString;
      oEnder.MunicipioIbgeId := Tab.Fields[14 { MUNICIPIO_IBGE_ID } ].AsString;

      oEnder.Bairro := Tab.Fields[4 { BAIRRO } ].AsString;
      oEnder.Logradouro := Tab.Fields[1 { LOGRADOURO } ].AsString;
      oEnder.Numero := Tab.Fields[2 { NUMERO } ].AsString;
      oEnder.Complemento := Tab.Fields[3 { COMPLEMENTO } ].AsString;
      oEnder.DDD := Tab.Fields[8 { DDD } ].AsString;
      oEnder.Fone1 := Tab.Fields[9 { FONE1 } ].AsString;
      oEnder.Fone2 := Tab.Fields[10 { FONE2 } ].AsString;
      oEnder.Fone3 := Tab.Fields[11 { FONE3 } ].AsString;
      oEnder.Contato := Tab.Fields[12 { CONTATO } ].AsString;
      oEnder.Referencia := Tab.Fields[13 { REFERENCIA } ].AsString;

      Tab.Next;
    end;
  finally
    Tab.GotoBookmark(bm);
    Tab.FreeBookmark(bm);
  end;
end;

constructor TEnderFrame.Create(AOwner: TComponent; pPessEnt: IPessEnt;
  pPessDBI: IPessDBI; pAppObj: IAppObj; pOkExecute: TNotifyEvent; pErroOutput: IOutput);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  FOkExecute := pOkExecute;
  FErroOutput := pErroOutput;
  FAppObj := pAppObj;
  FPessEnt := pPessEnt;
  FPessDBI := pPessDBI;
  FFDMemTable := TFDMemTable.Create(Self);
  FFDMemTable.Name := ClassName + 'FDMemTable';
  FFDMemTable.AfterScroll := EnderecoFDMemTableAfterScroll;

  FEnderControlsFrame := TEnderControlsFrame.Create(Self, FPessEnt, FPessDBI,
    FFDMemTable, FOkExecute, FErroOutput);
  FEnderDBGridFrame := TEnderDBGridFrame.Create(Self, FPessEnt, FPessDBI,
    FFDMemTable, FOkExecute);

  FEnderControlsFrame.Visible := True;
  FEnderDBGridFrame.Visible := False;

  sNomeArq := GetNomeArqTabViewEndereco;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FFDMemTable,
    FEnderDBGridFrame.DBGrid1, TABVIEW_ENDER_ORDEM_INDEX);

end;

function TEnderFrame.DadosOk: boolean;
begin
  Result := FEnderControlsFrame.DadosOk;
end;

procedure TEnderFrame.EnderecoFDMemTableAfterScroll(DataSet: TDataSet);
begin

end;

procedure TEnderFrame.EntToControles;
var
  I: integer;
  oEnder: IPessEnder;
  Tab: TFDMemTable;
begin
  inherited;
  Tab := FFDMemTable;
  Tab.EmptyDataSet;
  for I := 0 to FPessEnt.PessEnderList.Count - 1 do
  begin
    oEnder := FPessEnt.PessEnderList[I];
    Tab.Append;
    Tab.Fields[0 {ENDER_ORDEM}].AsInteger := oEnder.Ordem;
    Tab.Fields[1 {LOGRADOURO}].AsString := oEnder.Logradouro;
    Tab.Fields[2 {NUMERO}].AsString := oEnder.Numero;
    Tab.Fields[3 {COMPLEMENTO}].AsString := oEnder.Complemento;
    Tab.Fields[4 {BAIRRO}].AsString := oEnder.Bairro;
    Tab.Fields[5 {MUNICIPIO_NOME}].AsString := oEnder.MunicipioNome;
    Tab.Fields[6 {UF_SIGLA}].AsString := oEnder.UFSigla;
    Tab.Fields[7 {CEP}].AsString := StrToOnlyDigit(oEnder.CEP);
    Tab.Fields[8 {DDD}].AsString := oEnder.DDD;
    Tab.Fields[9 {FONE1}].AsString := oEnder.Fone1;
    Tab.Fields[10 {FONE2}].AsString := oEnder.Fone2;
    Tab.Fields[11 {FONE3}].AsString := oEnder.Fone3;
    Tab.Fields[12 {CONTATO}].AsString := oEnder.Contato;
    Tab.Fields[13 {REFERENCIA}].AsString := oEnder.Referencia;
    Tab.Fields[14 {MUNICIPIO_IBGE_ID}].AsString := oEnder.MunicipioIbgeId;
    Tab.Fields[15 {ENDER_CRIADO_EM}].AsDateTime := oEnder.CriadoEm;
    Tab.Fields[16 {ENDER_ALTERADO_EM}].AsDateTime := oEnder.AlteradoEm;
    Tab.Post;
  end;

  FEnderControlsFrame.EntToControles;
  FEnderDBGridFrame.EntToControles;
end;

function TEnderFrame.GetNomeArqTabViewEndereco: string;
var
  sNomeArq: string;
begin
  sNomeArq := FAppObj.AppInfo.PastaConsTabViews +
    'App\Config\Ambiente\tabview.config.ambi.pess.loja.csv';
  Result := sNomeArq;
end;

procedure TEnderFrame.AjusteControles;
begin
  FEnderControlsFrame.AjusteControles;
  FEnderDBGridFrame.AjusteControles;
end;

end.
