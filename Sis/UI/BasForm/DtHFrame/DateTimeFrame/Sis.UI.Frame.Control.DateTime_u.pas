unit Sis.UI.Frame.Control.DateTime_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Control_u,
  Vcl.StdCtrls, Vcl.Mask;

type
  TDateTimeFrame = class(TControlBasFrame)
    NomeLabel: TLabel;
    DataMaskEdit: TMaskEdit;
    HoraMaskEdit: TMaskEdit;
    ErroLabel: TLabel;
    procedure DataMaskEditKeyPress(Sender: TObject; var Key: Char);
    procedure DataMaskEditChange(Sender: TObject);
    procedure HoraMaskEditChange(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure SetValue(const Value: variant); override;
    function GetValue: variant; override;
    procedure SetUltimoErro(const Value: string); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Value;
    procedure PegarNome(pNovoNome: string);
  end;

//var
//  DateTimeFrame: TDateTimeFrame;

implementation

uses Sis.Sis.Constants;

{$R *.dfm}

constructor TDateTimeFrame.Create(AOwner: TComponent);
begin
  inherited;
  UltimoErro := '';
end;

procedure TDateTimeFrame.DataMaskEditChange(Sender: TObject);
begin
  inherited;
  UltimoErro := '';
end;

procedure TDateTimeFrame.DataMaskEditKeyPress(Sender: TObject;
  var Key: Char);
begin
//  inherited;
  if key = #13 then
  begin
    key := #0;
    HoraMaskEdit.SetFocus;
  end;

end;

function TDateTimeFrame.GetValue: variant;
var
  DtStr, HrStr, FullDateTimeStr: string;
  Dt: TDateTime;
begin
  // Obtém as strings dos MaskEdits
  DtStr := DataMaskEdit.Text;
  HrStr := HoraMaskEdit.Text;

  // Monta string no formato 'dd/mm/yyyy hh:nn:ss'
  FullDateTimeStr := DtStr + ' ' + HrStr;

  // Valida com TryStrToDateTime
  if not TryStrToDateTime(FullDateTimeStr, Dt) then
  begin
    UltimoErro := 'Valor inválido';
    Dt := DATA_ZERADA;
  end;

  // Retorna como variant
  Result := Dt;
end;

procedure TDateTimeFrame.HoraMaskEditChange(Sender: TObject);
begin
  inherited;
  UltimoErro := '';
end;

procedure TDateTimeFrame.PegarNome(pNovoNome: string);
begin
 NomeLabel.Caption := pNovoNome;
 DataMaskEdit.Left := NomeLabel.Left + NomeLabel.Width + 5;
 HoraMaskEdit.Left := DataMaskEdit.Left + DataMaskEdit.Width + 6;
 Width := HoraMaskEdit.Left + HoraMaskEdit.Width;
end;

procedure TDateTimeFrame.SetUltimoErro(const Value: string);
begin
  inherited;
  ErroLabel.Caption := Value;
end;

procedure TDateTimeFrame.SetValue(const Value: variant);
var
  Dt: TDateTime;
  Dia, Mes, Ano, Hora, Minuto, Segundo, Milissegundo: Word;
 begin
  inherited;

  // Verifica se o Variant é nulo ou vazio
  if VarIsNull(Value) or VarIsEmpty(Value) then
  begin
    DataMaskEdit.Text := '  /  /    ';
    HoraMaskEdit.Text := '  :  :  ';
    Exit;
  end;

  // Tenta converter o Variant para TDateTime
  try
    Dt := VarToDateTime(Value);
  except
    on E: Exception do
    begin
      DataMaskEdit.Text := '  /  /    ';
      HoraMaskEdit.Text := '  :  :  ';
      Exit;
    end;
  end;

  if Dt < 3 then
  begin
    DataMaskEdit.Text := '  /  /    ';
    HoraMaskEdit.Text := '  :  :  ';
    Exit;
  end;
  // Extrai as partes da data e hora
  DecodeDate(Dt, Ano, Mes, Dia);
  DecodeTime(Dt, Hora, Minuto, Segundo, Milissegundo);

  // Preenche os MaskEdits com os valores formatados
  DataMaskEdit.Text := Format('%.2d/%.2d/%.4d', [Dia, Mes, Ano]);
  HoraMaskEdit.Text := Format('%.2d:%.2d:%.2d', [Hora, Minuto, Segundo]);
end;
end.
