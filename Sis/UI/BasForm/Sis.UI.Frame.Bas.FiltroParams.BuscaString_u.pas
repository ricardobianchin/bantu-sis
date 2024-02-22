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
    { Private declarations }
  protected
    function GetValues: variant; override;
    procedure SetValues(Value: variant); override;
    procedure AjusteValores; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pOnChange: TNotifyEvent);
  end;

//var
//  FiltroParamsStringFrame: TFiltroParamsStringFrame;

implementation

{$R *.dfm}

{ TFiltroParamsStringFrame }

procedure TFiltroParamsStringFrame.AjusteValores;
begin
  inherited;
  BuscaStringEdit.Text := StrSemCharRepetido(BuscaStringEdit.Text, #32)
end;

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

function TFiltroParamsStringFrame.GetValues: variant;
begin
  inherited;
//  Result := VarArrayCreate([0, 0], varVariant);
//  Result[0] := BuscaStringEdit.Text;
  Result := BuscaStringEdit.Text;
end;

procedure TFiltroParamsStringFrame.SetValues(Value: variant);
begin
  inherited;
  BuscaStringEdit.Text := VarToString(Value);
  AjusteValores;
end;

end.
