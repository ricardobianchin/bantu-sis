unit App.UI.Form.Ed.CxOperacao.UmValor_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Ed.CxOperacao_u, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  NumEditBtu;

type
  TCxOperUmValorEdForm = class(TCxOperacaoEdForm)
    ValorPanel: TPanel;
    Panel1: TPanel;
    ValorRadioButton: TRadioButton;
    NumerarioRadioButton: TRadioButton;
    ValorEdit: TEdit;
  private
    { Private declarations }
    PrecoNovEdit: TNumEditBtu;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  CxOperUmValorEdForm: TCxOperUmValorEdForm;

implementation

{$R *.dfm}
{ TCxOperUmValorEdForm }

constructor TCxOperUmValorEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited;
{  PrecoNovEdit := TNumEditBtu.Create(Self);
  PrecoNovEdit.Parent := PrecoGroupBox;
  PrecoNovEdit.Alignment := taRightJustify;
  PrecoNovEdit.NCasas := 2;
  PrecoNovEdit.NCasasEsq := 7;
  PrecoNovEdit.Caption := 'Novo';
  PrecoNovEdit.LabelPosition := lpLeft;
  PrecoNovEdit.LabelSpacing := 4;

  PrecoNovEdit.Width := 75;
  PrecoNovEdit.Left := 38;
  PrecoNovEdit.Top := 15;
 }
end;

end.
