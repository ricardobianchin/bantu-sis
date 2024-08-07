unit Sis.UI.Controls.TLabeledEdit;

interface

uses Vcl.StdCtrls, Vcl.ExtCtrls, Sis.UI.IO.Output, Data.DB;

function TesteEditVazio(pEdit: TEdit; pNomeCampo: string; pErroOutput: IOutput): boolean;

function TesteEditValorInalterado(pEdit: TEdit; pNomeCampo: string;
  pValorOriginal: string; pDataSetState: TDataSetState;
  pErroOutput: IOutput): boolean;

////
function TesteLabeledEditVazio(pLabeledEdit: TLabeledEdit;
  pErroOutput: IOutput): boolean;

function TesteLabeledEditValorInalterado(pLabeledEdit: TLabeledEdit;
  pValorOriginal: string; pDataSetState: TDataSetState;
  pErroOutput: IOutput): boolean;

implementation

uses Sis.Types.strings_u, System.SysUtils;

function TesteEditVazio(pEdit: TEdit; pNomeCampo: string; pErroOutput: IOutput): boolean;
var
  sFrase: string;
  iId: smallint;
  sValorDigitado: string;
  sFormat: string;
begin
  pEdit.Text := StrSemCharRepetido(pEdit.Text, #32);
  sValorDigitado := pEdit.Text;

  Result := sValorDigitado <> '';
  if not Result then
  begin
    sFormat := 'Campo ''%s'' � obrigat�rio';
    sFrase := Format(sFormat, [pNomeCampo]);
    pErroOutput.Exibir(sFrase);
    pEdit.SetFocus;
  end;
end;


function TesteEditValorInalterado(pEdit: TEdit; pNomeCampo: string;
  pValorOriginal: string; pDataSetState: TDataSetState;
  pErroOutput: IOutput): boolean;
var
  sFrase: string;
  iId: smallint;
  sValorDigitado: string;
  sFormat: string;
begin
  sValorDigitado := pEdit.Text;

  Result := pDataSetState <> dsEdit;
  if Result then
    exit;

  Result := sValorDigitado <> pValorOriginal;

  if not Result then
  begin
    sFormat := 'Campo %s igual ao j� existente';
    sFrase := Format(sFormat, [pNomeCampo]);
    pErroOutput.Exibir(sFrase);
    pEdit.SetFocus;
  end;
end;

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
    sFormat := 'Campo ''%s'' � obrigat�rio';
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

  Result := pDataSetState <> dsEdit;
  if Result then
    exit;

  Result := sValorDigitado <> pValorOriginal;

  if not Result then
  begin
    sFormat := 'Campo %s igual ao j� existente';
    sFrase := Format(sFormat, [sNomeCampo]);
    pErroOutput.Exibir(sFrase);
    pLabeledEdit.SetFocus;
  end;
end;

end.
