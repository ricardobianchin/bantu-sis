unit App.Retag.Est.Prod.Barras.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.ImgDM, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons, App.AppInfo,
  App.Retag.Est.Prod.Barras.Ent.List, App.Retag.Est.Prod.Barras.List.Form_u;

type
  TProdBarrasFrame = class(TFrame)
    LabeledEdit1: TLabeledEdit;
    BarrasListSpeedButton: TSpeedButton;
    ConsultarWebSpeedButton: TSpeedButton;
    ErroLabel: TLabel;
    procedure ConsultarWebSpeedButtonClick(Sender: TObject);
    procedure BarrasListSpeedButtonClick(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
  private
    { Private declarations }
    FProdBarrasList: IProdBarrasList;
    FAppInfo: IAppInfo;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pProdBarrasList: IProdBarrasList;
      pAppInfo: IAppInfo);
  end;

implementation

{$R *.dfm}

uses ShellAPI, App.Retag.Est.Prod.Barras.Ent, Data.DB, Sis.Types.Codigos.Utils;

constructor TProdBarrasFrame.Create(AOwner: TComponent;
  pProdBarrasList: IProdBarrasList; pAppInfo: IAppInfo);
begin
  inherited Create(AOwner);
  FProdBarrasList := pProdBarrasList;
  FAppInfo := pAppInfo;
end;

procedure TProdBarrasFrame.LabeledEdit1Change(Sender: TObject);
begin
  ErroLabel.Visible := false;
end;

procedure TProdBarrasFrame.BarrasListSpeedButtonClick(Sender: TObject);
var
  I: integer;
  ProdBarras: IProdBarras;
  q: TDataSet;
begin
  if not EAN13Valido(LabeledEdit1.Text) then
  begin
    ErroLabel.Caption := 'Código de barras inválido';
    ErroLabel.Visible := True;
    LabeledEdit1.SetFocus;
    exit;
  end;

  ProdBarrasListForm := TProdBarrasListForm.Create(Application, FAppInfo);
  q := ProdBarrasListForm.FDMemTable;

  try
    if FProdBarrasList.Count = 0 then
      FProdBarrasList.PegarBarras(LabeledEdit1.Text)
    else
      FProdBarrasList[0].Barras := LabeledEdit1.Text;
    q.DisableControls;
    try
      for I := 0 to FProdBarrasList.Count - 1 do
      begin
        ProdBarras := FProdBarrasList[I];
        q.InsertRecord([I + 1, ProdBarras.Barras]);
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
        FProdBarrasList.PegarBarras(q.fields[1].asstring);
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

end.
