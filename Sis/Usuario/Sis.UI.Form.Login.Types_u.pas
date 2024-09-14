unit Sis.UI.Form.Login.Types_u;

interface

type
  TLoginPergModo = (ltLogando, ltMudandoSenha, ltCriandoSenha);

function LoginPergModoToStr(pLoginPergModo: TLoginPergModo): string;

implementation

function LoginPergModoToStr(pLoginPergModo: TLoginPergModo): string;
begin
  case pLoginPergModo of
    ltLogando: Result := 'Logando';
    ltMudandoSenha: Result := 'Mudando Senha';
    ltCriandoSenha: Result := 'Criando Senha';
  end;
end;

end.
