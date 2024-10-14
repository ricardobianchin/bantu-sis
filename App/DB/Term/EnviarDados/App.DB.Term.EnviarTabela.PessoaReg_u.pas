unit App.DB.Term.EnviarTabela.PessoaReg_u;

interface

uses Sis.Entities.Types;

type
  TRegistro = record
    LOJA_ID: TLojaId;
    TERMINAL_ID: TTerminalId;
    PESSOA_ID: integer;
    NOME: string;
    NOME_FANTASIA: string;
    APELIDO: string;
    GENERO_ID: string;
    ESTADO_CIVIL_ID: string;
    C: string;
    I: string;
    M: string;
    M_UF: string;
    EMAIL: string;
    DT_NASC: TDateTime;
    ATIVO: Boolean;
    CRIADO_EM: TDateTime;
    ALTERADO_EM: TDateTime;
    function MesmoCod(pRegistro: TRegistro): boolean;
  end;

implementation

{ TRegistro }

function TRegistro.MesmoCod(pRegistro: TRegistro): boolean;
begin
  Result := PESSOA_ID = pRegistro.PESSOA_ID;
  if not Result then
    exit;

  Result := TERMINAL_ID = pRegistro.TERMINAL_ID;
  if not Result then
    exit;

  Result := LOJA_ID = pRegistro.LOJA_ID;
end;

end.
