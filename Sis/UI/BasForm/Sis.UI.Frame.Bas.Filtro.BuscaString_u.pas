unit Sis.UI.Frame.Bas.Filtro.BuscaString_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Filtro_u,
  Vcl.StdCtrls, Vcl.ExtCtrls, Sis.Types.strings_u, data.db;

type
  TFiltroStringFrame = class(TFiltroFrame)
    FiltroTitLabel: TLabel;
    BuscaStringEdit: TEdit;
    procedure BuscaStringEditChange(Sender: TObject);
    procedure BuscaStringEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    function GetValues: variant; override;
    procedure SetValues(Value: variant); override;
  public
    { Public declarations }
    procedure AjusteValores; override;
  end;

var
  FiltroStringFrame: TFiltroStringFrame;

implementation

{$R *.dfm}

procedure TFiltroStringFrame.AjusteValores;
begin
  inherited;
  BuscaStringEdit.Text := StrSemCharRepetido(BuscaStringEdit.Text, #32)
end;

procedure TFiltroStringFrame.BuscaStringEditChange(Sender: TObject);
begin
  inherited;
  AgendeChange;
end;

procedure TFiltroStringFrame.BuscaStringEditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  CharSemAcento(Key);

end;

function TFiltroStringFrame.GetValues: variant;
begin
  Result := inherited;
  Result := VarArrayCreate([0, 0], varVariant);
  Result[0] := BuscaStringEdit.Text;
end;

procedure TFiltroStringFrame.SetValues(Value: variant);
begin
//  inherited;
  // Acessando o primeiro elemento do vetor de variants
  if VarArrayDimCount(Value) > 0 then
    BuscaStringEdit.Text := VarToStr(Value[0])
  else
    BuscaStringEdit.Text := '';

  AjusteValores;
end;

end.
