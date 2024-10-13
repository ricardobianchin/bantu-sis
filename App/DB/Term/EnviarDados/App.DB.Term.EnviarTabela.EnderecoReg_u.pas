unit App.DB.Term.EnviarTabela.EnderecoReg_u;

interface

uses Sis.Entities.Types, Data.SqlTimSt;

type
  TRegistro = record
    LOJA_ID: TLojaId;
    TERMINAL_ID: TTerminalId;
    PESSOA_ID: integer;
    ORDEM: smallint;
    LOGRADOURO: string;
    NUMERO: string;
    COMPLEMENTO: string;
    BAIRRO: string;
    UF_SIGLA: string;
    CEP: string;
    MUNICIPIO_IBGE_ID: string;
    DDD: string;
    FONE1: string;
    FONE2: string;
    FONE3: string;
    CONTATO: string;
    REFERENCIA: string;
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

  Result := ORDEM = pRegistro.ORDEM;
  if not Result then
    exit;

  Result := TERMINAL_ID = pRegistro.TERMINAL_ID;
  if not Result then
    exit;

  Result := LOJA_ID = pRegistro.LOJA_ID;
end;

end.
