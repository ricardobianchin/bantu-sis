unit Sis.UI.Controls.TLabeledEdit;

interface

uses Vcl.ExtCtrls, Sis.UI.IO.Output, Data.DB;

function TesteLabeledEditVazio(pLabeledEdit: TLabeledEdit;
  pErroOutput: IOutput): boolean;

function TesteLabeledEditValorInalterado(pLabeledEdit: TLabeledEdit;
  pValorOriginal: string; pDataSetState: TDataSetState;
  pErroOutput: IOutput): boolean;

implementation

uses Sis.Types.strings_u, System.SysUtils;

function TesteLabeledEditVazio(pLabeledEdit: TLabeledEdit;
  pErroOutput: IOutput): boolean;
var
  sFrase: string;
  sNomeCampo: string;
  iId: smallint;
  sValorDigitado: string;
  sFormat: string;
begin
  pLabeledEdit.Text := StrSemCharRepetido(pLabeledEdit.Text, #32);
  sValorDigitado := pLabeledEdit.Text;
  sNomeCampo := pLabeledEdit.EditLabel.Caption;

  Result := sValorDigitado <> '';
  if not Result then
  begin
    sFormat := 'Campo ''%s'' é obrigatório';
    sFrase := Format(sFormat, [sNomeCampo]);
    pErroOutput.Exibir(sFrase);
    pLabeledEdit.SetFocus;
  end;
end;

function TesteLabeledEditValorInalterado(pLabeledEdit: TLabeledEdit;
  pValorOriginal: string; pDataSetState: TDataSetState;
  pErroOutput: IOutput): boolean;
var
  sFrase: string;
  sNomeCampo: string;
  iId: smallint;
  sValorDigitado: string;
  sFormat: string;
begin
  sValorDigitado := pLabeledEdit.Text;
  sNomeCampo := pLabeledEdit.EditLabel.Caption;

  Result := pDataSetState = dsEdit;
  if not Result then
    exit;

  Result := sValorDigitado <> pValorOriginal;

  if not Result then
  begin
    sFormat := 'Campo %s igual ao já existente';
    sFrase := Format(sFormat, [sNomeCampo]);
    pErroOutput.Exibir(sFrase);
    pLabeledEdit.SetFocus;
  end;
end;

end.
