unit Sis.Entities.Factory;

interface

uses Sis.Usuario, Sis.Loja;

function UsuarioCreate(pLojaId: integer = 0; pTerminalId: integer = 0;
  pId: integer = 0; pNomeCompleto: string = ''; pNomeExib: string = '';
  pNomeUsu: string = ''; pSenha: string = ''): IUsuario;

function LojaCreate(pDescr:string=''; pId:integer=0): ILoja;

implementation

uses Sis.Usuario_u, Sis.Loja_u;

function UsuarioCreate(pLojaId: integer = 0; pTerminalId: integer = 0;
  pId: integer = 0; pNomeCompleto: string = ''; pNomeExib: string = '';
  pNomeUsu: string = ''; pSenha: string = ''): IUsuario;
begin
  Result := TUsuario.Create(pLojaId, pTerminalId, pId, pNomeCompleto, pNomeExib,
    pNomeUsu, pSenha);
end;


function LojaCreate(pDescr:string=''; pId:integer=0): ILoja;
begin
  Result := TLoja.Create(pDescr, pId);
end;

end.
