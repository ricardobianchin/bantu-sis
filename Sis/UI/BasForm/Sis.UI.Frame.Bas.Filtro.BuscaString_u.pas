unit Sis.UI.Frame.Bas.Filtro.BuscaString_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
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
  public
    { Public declarations }
  end;

//var
//  FiltroStringFrame: TFiltroStringFrame;

implementation

{$R *.dfm}

procedure TFiltroStringFrame.FiltroStringEditChange(Sender: TObject);
begin
  inherited;
  AgendeChange;
end;

procedure TFiltroStringFrame.FiltroStringEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if key = #13 then
  begin
    key := #0;
    DoChange;
  end;
  CharSemAcento(Key);
end;

function TFiltroStringFrame.GetValues: variant;
begin
  Result := inherited;
  Result[0] := FiltroStringEdit.Text;
end;

procedure TFiltroStringFrame.SetValues(Value: variant);
begin
//  inherited;
  // Acessando o primeiro elemento do vetor de variants
  if VarArrayDimCount(Value) > 0 then
  begin
    FiltroStringEdit.Text := VarToStr(Value[0]);

    // Define o cursor no final do texto
    FiltroStringEdit.SelStart := Length(FiltroStringEdit.Text);

    // Define o tamanho da seleção como zero
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
