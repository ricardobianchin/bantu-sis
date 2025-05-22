unit App.Retag.Est.ProdSelectFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Sis.DBI,
  Sis.UI.Frame.Bas.Filtro_u, Sis.UI.Select, Sis.DB.DBTypes, App.AppObj,
  Vcl.Buttons, Sis.Types, Sis.UI.FormCreator, Sis.UI.IO.Output, Sis.Usuario,
  Sis.UI.IO.Output.ProcessLog;

type
  TProdSelectFrame = class(TBasFrame)
    ProdLabeledEdit: TLabeledEdit;
    BuscaSpeedButton: TSpeedButton;
    ListaSpeedButton: TSpeedButton;
    procedure BuscaSpeedButtonClick(Sender: TObject);
    procedure ProdLabeledEditClick(Sender: TObject);
    procedure ListaSpeedButtonClick(Sender: TObject);
  private
    { Private declarations }
    FDBConnection: IDBConnection;
    FAppObj: IAppObj;

    FProdSelectDBI: IDBI;
    FProdSelectFiltroFrame: TFiltroFrame;
    FProdSelect: ISelect;

    FProdId: TId;
    FProdDescrRed: string;
    FProdBalancaExige: Boolean;
    FProdFabrNome: string;

    FOnSelect: TNotifyEvent;

    FProdFormCreator: IFormCreator;
    DummyFormClassNamesSL: TStringList;

    function ProdSelectDBICreate: IDBI;
    function ProdSelectFiltroFrameCreate: TFiltroFrame;
    function ProdSelectCreate: ISelect;

  public
    { Public declarations }
    property ProdId: TId read FProdId;
    property ProdDescrRed: string read FProdDescrRed;
    property ProdBalancaExige: Boolean read FProdBalancaExige;
    property ProdFabrNome: string read FProdFabrNome;

    property OnSelect: TNotifyEvent read FOnSelect write FOnSelect;

    procedure Selecionar;

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
  Sis.Types.Bool_u, App.Retag.Est.Factory;

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

  Sis.UI.Controls.Utils.ReadOnlySet(ProdLabeledEdit, True);

  FProdFormCreator := ProdFormCreatorCreate(DummyFormClassNamesSL, pUsuarioLog,
    pDBMS, pOutput, pProcessLog, pOutputNotify, pAppObj, pDBConnection);
end;

destructor TProdSelectFrame.Destroy;
begin
  DummyFormClassNamesSL.Free;
  inherited;
end;

procedure TProdSelectFrame.ListaSpeedButtonClick(Sender: TObject);
var
  Resultado: Boolean;
  SelectItem: TSelectItem;
  a: TArray<string>;
  s: string;
begin
  inherited;
  SelectItem.Id := ProdId;
  Resultado := FProdFormCreator.PergSelect(SelectItem);
  if not Resultado then
    exit;

  FProdId := SelectItem.Id;
  s := SelectItem.Descr;
  a := s.Split([';']);
  FProdDescrRed := a[1];
  FProdBalancaExige := StrToBoolean(a[3]);
  FProdFabrNome := a[2];
  ProdLabeledEdit.Text := a[0] + ' - ' + a[1];

  if Assigned(FOnSelect) then
    FOnSelect(Self);
end;

procedure TProdSelectFrame.ProdLabeledEditClick(Sender: TObject);
begin
  inherited;
  ListaSpeedButton.Click;
  // Selecionar;
end;

function TProdSelectFrame.ProdSelectCreate: ISelect;
begin
  Result := DBSelectFormCreate(FProdSelectDBI, FProdSelectFiltroFrame);
end;

function TProdSelectFrame.ProdSelectDBICreate: IDBI;
begin
  Result := TProdSelectDBI.Create(FDBConnection, FAppObj);
end;

function TProdSelectFrame.ProdSelectFiltroFrameCreate: TFiltroFrame;
begin
  Result := TFiltroStringFrame.Create(Self, nil);
end;

procedure TProdSelectFrame.Selecionar;
var
  s: string;
  a: TArray<string>;
begin
  ListaSpeedButton.Click;
  exit;

  if FProdSelect.Execute('') then
  begin
    s := FProdSelect.LastSelected;
    a := s.Split([';']);

    FProdId := StrToInt(a[0]);
    FProdDescrRed := a[1];
    FProdFabrNome := a[2];
    FProdBalancaExige := StrToBoolean(a[3]);

    ProdLabeledEdit.Text := a[0] + ' - ' + a[1];

    if Assigned(FOnSelect) then
      FOnSelect(Self);
  end;
end;

end.
