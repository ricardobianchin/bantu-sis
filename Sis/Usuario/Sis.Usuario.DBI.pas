unit Sis.Usuario.DBI;

interface

uses Sis.DBI, Sis.ModuloSistema.Types;

type
  IUsuarioDBI = interface(IDBI)
    ['{AAE3F320-DDBC-47E9-B444-DC8CDCA066E5}']
    function UsuarioPeloNomeDeUsuario(pNomeUsuDig: string; out pCryVer: integer;
      out Senha, pApelido, pModulosSistema, pMens: string;
      out pEncontrado: boolean): boolean;

    function GravarSenha(out pMens: string): boolean;
  end;

implementation

end.
