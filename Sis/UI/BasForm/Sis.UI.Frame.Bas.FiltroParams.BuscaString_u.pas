unit Sis.UI.Frame.Bas.FiltroParams.BuscaString_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.FiltroParams_u,
  Vcl.StdCtrls, Vcl.ExtCtrls, Sis.Types.strings_u, data.db;

type
  TFiltroParamsStringFrame = class(TFiltroParamsFrame)
    BuscaStringEdit: TEdit;
    FiltroTitLabel: TLabel;
    procedure BuscaStringEditChange(Sender: TObject);
    procedure BuscaStringEditKeyPress(Sender: TObject; var Key: Char);
  private
    function GetBuscaString: string;
    procedure SetBuscaString(const Value: string);
    { Private declarations }
  protected
  public
    { Public declarations }
    property BuscaString: string read GetBuscaString write SetBuscaString;
    constructor Create(AOwner: TComponent; pOnChange: TNotifyEvent);
  end;

var
  FiltroParamsStringFrame: TFiltroParamsStringFrame;

implementation

{$R *.dfm}

{ TFiltroParamsStringFrame }

procedure TFiltroParamsStringFrame.BuscaStringEditChange(Sender: TObject);
begin
  inherited;
  AgendeChange;

end;

procedure TFiltroParamsStringFrame.BuscaStringEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  CharSemAcento(Key);

end;

constructor TFiltroParamsStringFrame.Create(AOwner: TComponent; pOnChange: TNotifyEvent);
begin
  inherited Create(AOwner);
  OnChange := pOnChange;
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
