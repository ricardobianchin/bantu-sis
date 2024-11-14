unit App.PDV.Preco.PrecoBusca.Um.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas_u, Vcl.StdCtrls,
  Data.DB;

type
  TPrecoBuscaUmFrame = class(TBasFrame)
    PrecoLabel: TLabel;
    DescrLabel: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Zerar;
    procedure PegarRecord(q: TDataSet);
    constructor Create(AOwner: TComponent); override;
  end;

var
  PrecoBuscaUmFrame: TPrecoBuscaUmFrame;

implementation

{$R *.dfm}
{ TPrecoBuscaUmFrame }

constructor TPrecoBuscaUmFrame.Create(AOwner: TComponent);
begin
  inherited;
  Zerar;
end;

procedure TPrecoBuscaUmFrame.PegarRecord(q: TDataSet);
begin
  if not Assigned(q) then
  begin
    Zerar;
    exit;
  end;

  if q.IsEmpty then
  begin
    Zerar;
    exit;
  end;
  PrecoLabel.Caption := q.FieldByName('PRECO').AsCurrency.ToString;
  DescrLabel.Caption := q.FieldByName('PROD_ID').AsInteger.ToString //
    + ' - ' //
    + q.FieldByName('DESCR').AsString.Trim //
    + #13#10 //
    + 'FABRICANTE: ' + q.FieldByName('FABR_NOME').AsString.Trim //
    + ' CÓDIGO DE BARRAS: ' //
    + q.FieldByName('CODS_BARRAS').AsString.Trim //
    ;
end;

procedure TPrecoBuscaUmFrame.Zerar;
begin
  PrecoLabel.Caption := 'R$ 0,00';
  DescrLabel.Caption := '';
end;

end.
