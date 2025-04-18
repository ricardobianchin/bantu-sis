unit Sis.UI.Frame.Bas.Filtro.BuscaString_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Filtro_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, Sis.Types.strings_u;

type
  TFiltroStringFrame = class(TFiltroFrame)
    FiltroTitLabel: TLabel;
    FiltroStringEdit: TEdit;
    procedure FiltroStringEditKeyPress(Sender: TObject; var Key: Char);
    procedure FiltroStringEditChange(Sender: TObject);
  private
    { Private declarations }
  protected
    function GetValues: variant; override;
    procedure SetValues(Value: variant); override;
    function NewArrayCreate: variant; override;
    procedure SetFontSize(const Value: integer); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pOnChange: TNotifyEvent); override;
  end;

  // var
  // FiltroStringFrame: TFiltroStringFrame;

implementation

{$R *.dfm}

constructor TFiltroStringFrame.Create(AOwner: TComponent;
  pOnChange: TNotifyEvent);
begin
  inherited;
  FiltroStringEdit.Text := '';
  ProcessaFiltro := True;
end;

procedure TFiltroStringFrame.FiltroStringEditChange(Sender: TObject);
begin
  inherited;
  AgendeChange;
end;

procedure TFiltroStringFrame.FiltroStringEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    DoChange;
  end;
  CharSemAcento(Key);
end;

function TFiltroStringFrame.GetValues: variant;
begin
  Result := inherited;
  Result[0] := FiltroStringEdit.Text;
end;

procedure TFiltroStringFrame.SetFontSize(const Value: integer);
var
  iMarg: integer;
begin
  inherited;
  FiltroStringEdit.Font.Size := Value;
  FiltroStringEdit.Width := (130 * Value) div 9;
  iMarg := FiltroStringEdit.Width div 20;
  FiltroTitLabel.Font.Size := Value;
  FiltroStringEdit.Left := FiltroTitLabel.Left + FiltroTitLabel.Width + iMarg;

end;

procedure TFiltroStringFrame.SetValues(Value: variant);
begin
  // inherited;
  // Acessando o primeiro elemento do vetor de variants
  if VarArrayDimCount(Value) > 0 then
  begin
    FiltroStringEdit.Text := VarToStr(Value[0]);

    // Define o cursor no final do texto
    FiltroStringEdit.SelStart := Length(FiltroStringEdit.Text);

    // Define o tamanho da sele��o como zero
    FiltroStringEdit.SelLength := 0;
  end
  else
    FiltroStringEdit.Text := '';

  AjusteValores;
end;

function TFiltroStringFrame.NewArrayCreate: variant;
begin
  Result := VarArrayCreate([0, 0], varVariant);
end;

end.
