unit App.Retag.Est.Prod.Barras.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.ImgDM, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons, App.AppObj,
  App.Retag.Est.Prod.Barras.Ent.List, App.Retag.Est.Prod.Barras.List.Form_u,
  App.Est.Prod.Barras.DBI;

type
  TProdBarrasFrame = class(TFrame)
    LabeledEdit1: TLabeledEdit;
    ConsultarWebSpeedButton: TSpeedButton;

    BarrasListSpeedButton: TSpeedButton;
    ErroLabel: TLabel;

    // abre lista
    procedure BarrasListSpeedButtonClick(Sender: TObject);

    // web
    procedure ConsultarWebSpeedButtonClick(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);

  private
    { Private declarations }
    FProdBarrasList: IProdBarrasList;
    FAppObj: IAppObj;
    FBarrasDBI: IBarrasDBI;
    FProdId: integer;
    procedure ErroMens(pFrase: string);
  public
    { Public declarations }
    function ControlesOk: boolean; virtual;
    function DadosOk: boolean; virtual;
    function PodeOk: boolean;

    property ProdBarrasList: IProdBarrasList read FProdBarrasList;
    constructor Create(AOwner: TComponent; pProdBarrasList: IProdBarrasList;
      pAppObj: IAppObj; pBarrasDBI: IBarrasDBI; pProdId: integer);
  end;

implementation

{$R *.dfm}

uses ShellAPI, App.Retag.Est.Prod.Barras.Ent, Data.DB, Sis.Types.Codigos.Utils,
  Sis.Lists.Types;

constructor TProdBarrasFrame.Create(AOwner: TComponent;
  pProdBarrasList: IProdBarrasList; pAppObj: IAppObj; pBarrasDBI: IBarrasDBI;
  pProdId: integer);
begin
  inherited Create(AOwner);
  FProdBarrasList := pProdBarrasList;
  FAppObj := pAppObj;
  FBarrasDBI := pBarrasDBI;
  FProdId := pProdId;

  if FProdBarrasList.Count > 0 then
    LabeledEdit1.Text := FProdBarrasList[0].Barras;
end;

function TProdBarrasFrame.DadosOk: boolean;
var
  iProdIdOutro: integer;
  sCodBarras: string;
begin
  sCodBarras := LabeledEdit1.Text;
  iProdIdOutro := FBarrasDBI.CodBarrasToProdId(sCodBarras, FProdId);

  Result := iProdIdOutro = 0;
  if not Result then
  begin // 7896422515658 7897424080984
    ErroMens('C�digo usado no Produto ' + iProdIdOutro.ToString);
    exit;
  end;

end;

procedure TProdBarrasFrame.ErroMens(pFrase: string);
begin
  ErroLabel.Caption := pFrase;
  ErroLabel.Visible := True;
  LabeledEdit1.SetFocus;
end;

procedure TProdBarrasFrame.LabeledEdit1Change(Sender: TObject);
begin
  ErroLabel.Visible := false;
end;

function TProdBarrasFrame.PodeOk: boolean;
begin
  Result := ControlesOk;
  if not Result then
    exit;

  Result := DadosOk;
end;

procedure TProdBarrasFrame.BarrasListSpeedButtonClick(Sender: TObject);
var
  I: integer;
  ProdBarras: IProdBarras;
  q: TDataSet;
  Resultado: boolean;
begin
  Resultado := PodeOk;
  if not Resultado then
    exit;

  ProdBarrasListForm := TProdBarrasListForm.Create(Application, FAppObj,
    FBarrasDBI, FProdId);
  q := ProdBarrasListForm.FDMemTable;

  try
    if FProdBarrasList.Count = 0 then
      FProdBarrasList.PegarBarras(LabeledEdit1.Text, plFim)
    else
      FProdBarrasList[0].Barras := LabeledEdit1.Text;

    q.DisableControls;
    try
      for I := 0 to FProdBarrasList.Count - 1 do
      begin
        ProdBarras := FProdBarrasList[I];
        q.Append;
        q.Fields[0].AsInteger := I + 1;
        q.Fields[1].AsString := ProdBarras.Barras;
        q.Post;
      end;
    finally
      q.EnableControls;
    end;

    if not IsPositiveResult(ProdBarrasListForm.ShowModal) then
      exit;

    q.DisableControls;
    try
      q.First;
      FProdBarrasList.Clear;

      while not q.Eof do
      begin
        FProdBarrasList.PegarBarras(q.fields[1].asstring, plFim);
        q.Next;
      end;

      if FProdBarrasList.Count > 0 then
        LabeledEdit1.Text := FProdBarrasList[0].Barras;
    finally
      q.EnableControls;
    end;
  finally
    ProdBarrasListForm.Free;
  end;
end;

procedure TProdBarrasFrame.ConsultarWebSpeedButtonClick(Sender: TObject);
var
  Url: string;
begin
  Url := 'https://www.google.com/search?q=' //
    + 'produto+com+%22c%C3%B3digo+de+barras%22+%22' //
    + LabeledEdit1.Text //
    + '%22%3F' //
    ;

  ShellExecute(0, 'open', PChar(Url), nil, nil, SW_SHOWNORMAL);
end;

function TProdBarrasFrame.ControlesOk: boolean;
var
  I: integer;
  ProdBarras: IProdBarras;
  q: TDataSet;
  sBarras: string;
begin
  LabeledEdit1.Text := Trim(LabeledEdit1.Text);
  sBarras := LabeledEdit1.Text;
  Result := sBarras = '';
  if Result then
    exit;

  Result := BarCodValido(sBarras);

  if not Result then
  begin // 7896422515658
    ErroMens('C�digo de barras inv�lido');
    exit;
  end;

  FProdBarrasList.PegarBarras(sBarras, plInicio);
end;

end.
