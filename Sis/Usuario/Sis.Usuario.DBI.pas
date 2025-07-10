unit Sis.Usuario.DBI;

interface

uses Sis.DBI, Sis.ModuloSistema.Types;

type
  IUsuarioDBI = interface(IDBI)
    ['{AAE3F320-DDBC-47E9-B444-DC8CDCA066E5}']
    function UsuarioPeloNomeDeUsuario(pNomeUsuDig: string;
      out pApelido, pMens: string; out pEncontrado: boolean): boolean;

    function LoginValide(pOpcaoSisIdModuloTentando: TOpcaoSisId;
      out pAceito: boolean; out pMens: string): boolean;

    function GravarSenha(out pMens: string): boolean;

    procedure Leia;
    procedure LeiaAdmin;
  end;

implementation

end.
