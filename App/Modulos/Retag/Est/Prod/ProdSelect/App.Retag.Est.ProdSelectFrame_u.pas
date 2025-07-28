unit App.Retag.Est.ProdSelectFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Sis.DBI,
  Sis.UI.Frame.Bas.Filtro_u, Sis.UI.Select, Sis.DB.DBTypes, App.AppObj,
  Vcl.Buttons, Sis.Types, Sis.UI.FormCreator, Sis.UI.IO.Output, Sis.Usuario,
  Sis.UI.IO.Output.ProcessLog, App.Retag.Est.ProdSelectDBI;

type
  TProdSelectFrame = class(TBasFrame)
    ProdLabeledEdit: TLabeledEdit;
    BuscaSpeedButton: TSpeedButton;
    ListaSpeedButton: TSpeedButton;
    procedure BuscaSpeedButtonClick(Sender: TObject);
    procedure ProdLabeledEditClick(Sender: TObject);
    procedure ListaSpeedButtonClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure ProdLabeledEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FDBConnection: IDBConnection;
    FAppObj: IAppObj;

    FProdSelectDBI: IProdSelectDBI;
    FProdSelectFiltroFrame: TFiltroFrame;
    FProdSelect: ISelect;

    FProdId: TId;
    FProdDescrRed: string;
    FProdBalancaExige: Boolean;
    FProdFabrNome: string;
    FCusto: Currency;
    FMargem: Currency;
    FPreco: Currency;
    FBarras: string;

    FOnSelect: TNotifyEvent;

    FProdFormCreator: IFormCreator;
    DummyFormClassNamesSL: TStringList;

    function ProdSelectDBICreate: IProdSelectDBI;
    function ProdSelectFiltroFrameCreate: TFiltroFrame;
    function ProdSelectCreate: ISelect;

  public
    { Public declarations }
    property ProdId: TId read FProdId;
    property ProdDescrRed: string read FProdDescrRed;
    property ProdBalancaExige: Boolean read FProdBalancaExige;
    property ProdFabrNome: string read FProdFabrNome;
    property Custo: Currency read FCusto;
    property Margem: Currency read FMargem;
    property Preco: Currency read FPreco;
    property Barras: string read FBarras;

    property OnSelect: TNotifyEvent read FOnSelect write FOnSelect;

    procedure Selecionar(pStrBusca: string);
    procedure PegarProdId(pProdId: integer);

    constructor Create(AOwner: TComponent; pDBConnection: IDBConnection;
      pAppObj: IAppObj; pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput); reintroduce;
    destructor Destroy; override;
  end;

var
  ProdSelectFrame: TProdSelectFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.UI.Controls.Factory, Sis.UI.ImgDM,
  Sis.UI.Frame.Bas.Filtro.BuscaString_u, App.Retag.Est.ProdSelectDBI_u,
  Sis.Types.Bool_u, App.Retag.Est.Factory, Sis.Win.Utils_u, Sis.Types.Floats;

{ TProdSelectFrame }

procedure TProdSelectFrame.BuscaSpeedButtonClick(Sender: TObject);
begin
  inherited;
  // Selecionar;
end;

constructor TProdSelectFrame.Create(AOwner: TComponent;
  pDBConnection: IDBConnection; pAppObj: IAppObj; pUsuarioLog: IUsuario;
  pDBMS: IDBMS; pOutput: IOutput; pProcessLog: IProcessLog;
  pOutputNotify: IOutput);
begin
  inherited Create(AOwner);
  DummyFormClassNamesSL := TStringList.Create;

  FDBConnection := pDBConnection;
  FAppObj := pAppObj;

  FProdSelectDBI := ProdSelectDBICreate;
  FProdSelectFiltroFrame := ProdSelectFiltroFrameCreate;
  FProdSelect := ProdSelectCreate;

  FProdId := 0;
  FProdDescrRed := '';
  FProdFabrNome := '';
  FProdBalancaExige := False;
  FBarras := '';

  Sis.UI.Controls.Utils.ReadOnlySet(ProdLabeledEdit, True);

  FProdFormCreator := ProdFormCreatorCreate(DummyFormClassNamesSL, pUsuarioLog,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pAppObj, pDBConnection);
end;

destructor TProdSelectFrame.Destroy;
begin
  DummyFormClassNamesSL.Free;
  inherited;
end;

procedure TProdSelectFrame.FrameResize(Sender: TObject);
begin
  inherited;
  ListaSpeedButton.Left := Width - 27;
  ProdLabeledEdit.Width := Width - ProdLabeledEdit.Left - 30;
end;

procedure TProdSelectFrame.ListaSpeedButtonClick(Sender: TObject);
var
  Resultado: Boolean;
  SelectItem: TSelectItem;
  a: TArray<string>;
  SL: TStringList;
begin
  inherited;
  SelectItem.Id := ProdId;
  Resultado := FProdFormCreator.PergSelect(SelectItem);
  if not Resultado then
    exit;

  SL := TStringList.Create;
  try
    FProdId := SelectItem.Id;
    SL.Text := SelectItem.Descr;
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(SL.Text);
    // {$ENDIF}
    FProdDescrRed := SL.Values['DESCR_RED'];
    FProdFabrNome := SL.Values['FABR_NOME'];
    FProdBalancaExige := StrToBoolean(SL.Values['BALANCA_EXIGE']);
    FCusto := StrToCurrency(SL.Values['CUSTO']);
    FMargem := StrToCurrency(SL.Values['MARGEM']);
    FPreco := StrToCurrency(SL.Values['PRECO']);
    FBarras := SL.Values['CODBARRAS'];
  finally
    SL.Free;
  end;

  ProdLabeledEdit.Text := FProdId.ToString + ' - ' + FProdDescrRed;;

  if Assigned(FOnSelect) then
    FOnSelect(Self);
end;

procedure TProdSelectFrame.PegarProdId(pProdId: integer);
var
  vValues: variant;
  bErroDeu: Boolean;
  sErroMens: string;
begin
  FProdSelectDBI.PegarProd(pProdId, vValues, bErroDeu, sErroMens);

  if bErroDeu then
  begin
    // ShowMessage('Erro ao pegar produto: ' + sErroMens);
    exit;
  end;

  FProdId := pProdId;
  FProdDescrRed := vValues[1];
  FProdFabrNome := vValues[2];
  FProdBalancaExige := StrToBoolean(vValues[3]);
  FCusto := StrToCurr(vValues[4]);
  FMargem := StrToCurr(vValues[5]);
  FPreco := StrToCurr(vValues[6]);
  FBarras := vValues[7];

  ProdLabeledEdit.Text := FProdId.ToString + ' - ' + FProdDescrRed;
end;

procedure TProdSelectFrame.ProdLabeledEditClick(Sender: TObject);
begin
  inherited;
  ListaSpeedButton.Click;
  // Selecionar;
end;

procedure TProdSelectFrame.ProdLabeledEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_DOWN:
    begin
      if Shift = [] then
      begin
        Key := 0;
        Selecionar('');
      end;
    end;
  end;
end;

function TProdSelectFrame.ProdSelectCreate: ISelect;
begin
  Result := DBSelectFormCreate(FProdSelectDBI, FProdSelectFiltroFrame);
end;

function TProdSelectFrame.ProdSelectDBICreate: IProdSelectDBI;
begin
  Result := TProdSelectDBI.Create(FDBConnection, FAppObj, 0);
end;

function TProdSelectFrame.ProdSelectFiltroFrameCreate: TFiltroFrame;
begin
  Result := TFiltroStringFrame.Create(Self, nil);
end;

procedure TProdSelectFrame.Selecionar(pStrBusca: string);
var
  s: string;
  a: TArray<string>;
begin
//  ListaSpeedButton.Click;
//  exit;

  if FProdSelect.Execute('') then
  begin
    s := FProdSelect.LastSelected;
    a := s.Split([';']);

    FProdId := StrToInt(a[0]);
    FProdDescrRed := a[1];
    FProdFabrNome := a[2];
    FProdBalancaExige := StrToBoolean(a[3]);
    FCusto := StrToCurr(a[4]);
    FMargem := StrToCurr(a[5]);
    FPreco := StrToCurr(a[6]);
    FBarras := a[7];

    ProdLabeledEdit.Text := a[0] + ' - ' + a[1];

    if Assigned(FOnSelect) then
      FOnSelect(Self);
  end;
end;

end.
