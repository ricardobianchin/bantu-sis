unit App.UI.Form.PDV.Preco.Perg_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.Frame.Bas.DBGrid_u, Sis.Types.Utils_u, Sis.Types, App.PDV.PrecoPerg.Um.Frame_u,
  Vcl.Mask;

type
  TPrecoPregForm = class(TDiagBasForm)
    Panel1: TPanel;
    BuscaLabeledEdit: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FQtdExibindo: TQuantidade;
    FPrecoPergTodosFrame: TDBGridFrame;
    FPrecoPergUmFrame: TPrecoPergUmFrame;

    function GetQtdExibindo: TQuantidade;
    procedure SetQtdExibindo(const Value: TQuantidade);
  protected
    property QtdExibindo: TQuantidade read GetQtdExibindo write SetQtdExibindo;
    property PrecoPergTodosFrame: TDBGridFrame read FPrecoPergTodosFrame;
  public
    { Public declarations }
  end;

//var
//  PrecoPregForm: TPrecoPregForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils;

{ TPrecoPregForm }

function TPrecoPregForm.GetQtdExibindo: TQuantidade;
begin
  Result := FQtdExibindo;
end;

procedure TPrecoPregForm.FormCreate(Sender: TObject);
begin
  inherited;
  FPrecoPergTodosFrame := TDBGridFrame.Create(Self);
  FPrecoPergUmFrame := TPrecoPergUmFrame.Create(Self);
  ClearStyleElements(Self);
  FPrecoPergTodosFrame.left := 0;
  FPrecoPergTodosFrame.top := 0;
  FPrecoPergUmFrame.left := 150;
  FPrecoPergUmFrame.top := 20;
end;

procedure TPrecoPregForm.SetQtdExibindo(const Value: TQuantidade);
begin
  if FQtdExibindo = Value then
    exit;

  FQtdExibindo := Value;
end;

end.
