unit App.Retag.Est.ProdSelectFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Sis.DBI,
  Sis.UI.Frame.Bas.Filtro_u, Sis.UI.Select, Sis.DB.DBTypes, App.AppObj,
  Vcl.Buttons, Sis.Types;

type
  TProdSelectFrame = class(TBasFrame)
    ProdLabeledEdit: TLabeledEdit;
    BuscaSpeedButton: TSpeedButton;
    procedure BuscaSpeedButtonClick(Sender: TObject);
    procedure ProdLabeledEditClick(Sender: TObject);
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
      pAppObj: IAppObj); reintroduce;
  end;

var
  ProdSelectFrame: TProdSelectFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.UI.Controls.Factory, Sis.UI.ImgDM,
  Sis.UI.Frame.Bas.Filtro.BuscaString_u, App.Retag.Est.ProdSelectDBI_u,
  Sis.Types.Bool_u;

{ TProdSelectFrame }

procedure TProdSelectFrame.BuscaSpeedButtonClick(Sender: TObject);
begin
  inherited;
  Selecionar;
end;

constructor TProdSelectFrame.Create(AOwner: TComponent;
  pDBConnection: IDBConnection; pAppObj: IAppObj);
begin
  inherited Create(AOwner);

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
end;

procedure TProdSelectFrame.ProdLabeledEditClick(Sender: TObject);
begin
  inherited;
  Selecionar;
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
