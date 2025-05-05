unit Sis.UI.Frame.Control.DateTime_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Control_u,
  Vcl.StdCtrls, Vcl.Mask;

type
  TDateTimeFrame = class(TControlBasFrame)
    EstDtIniPessLabel: TLabel;
    DtMaskEdit: TMaskEdit;
    HoraMaskEdit: TMaskEdit;
    procedure DtMaskEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    procedure SetValue(const Value: variant); override;
    function GetValue: variant; override;
  public
    { Public declarations }
    property Value;
  end;

//var
//  DateTimeFrame: TDateTimeFrame;

implementation

uses Sis.Sis.Constants;

{$R *.dfm}

procedure TDateTimeFrame.DtMaskEditKeyPress(Sender: TObject;
  var Key: Char);
begin
//  inherited;
  if key = #13 then
  begin
    key := #0;

  end;

end;

function TDateTimeFrame.GetValue: variant;
var
  DtStr, HrStr, FullDateTimeStr: string;
  Dt: TDateTime;
begin
  // Obtém as strings dos MaskEdits
  DtStr := DtMaskEdit.Text;
  HrStr := HoraMaskEdit.Text;

  // Monta string no formato 'dd/mm/yyyy hh:nn:ss'
  FullDateTimeStr := DtStr + ' ' + HrStr;

  // Valida com TryStrToDateTime
  if not TryStrToDateTime(FullDateTimeStr, Dt) then
    raise Exception.Create('Data ou hora inválida. Verifique os valores informados.');

  // Retorna como variant
  Result := Dt;
end;

procedure TDateTimeFrame.SetValue(const Value: variant);
begin
  inherited;

end;

end.
