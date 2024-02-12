unit Sis.UI.Frame.Bas.FiltroParams.BuscaString_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.FiltroParams_u,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFiltroParamsStringFrame = class(TFiltroParamsFrame)
    BuscaStringEdit: TEdit;
    FiltroTitLabel: TLabel;
  private
    function GetBuscaString: string;
    procedure SetBuscaString(const Value: string);
    { Private declarations }
  protected
  public
    { Public declarations }
    property BuscaString: string read GetBuscaString write SetBuscaString;
    constructor Create(AOwner: TComponent);
  end;

var
  FiltroParamsStringFrame: TFiltroParamsStringFrame;

implementation

{$R *.dfm}

{ TFiltroParamsStringFrame }

constructor TFiltroParamsStringFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BuscaStringEdit.OnChange := OnChange;
end;

function TFiltroParamsStringFrame.GetBuscaString: string;
begin
  BuscaStringEdit.Text := Trim(BuscaStringEdit.Text);
  Result := BuscaStringEdit.Text;
end;

procedure TFiltroParamsStringFrame.SetBuscaString(const Value: string);
begin
  BuscaStringEdit.Text := Value;
end;

end.
