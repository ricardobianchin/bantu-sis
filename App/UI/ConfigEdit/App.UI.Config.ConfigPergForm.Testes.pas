unit App.UI.Config.ConfigPergForm.Testes;

interface

const
  CRIA_ARQ = True;
//  CRIA_ARQ = False;

type
  TConfigPergTeste = class(TObject)
  private
    FPastaBin: string;
    FPastaConfigs: string;

  public
    TesteEhServ: boolean;
    TesteMaqLocalBuscaNome: boolean;

    TesteUsuPreenche: boolean;
    TesteUsuNomeCompleto: string;
    TesteUsuNomeExib: string;
    TesteUsuNomeUsu: string;
    TesteUsuSenha1: string;
    TesteUsuSenha2: string;
    TesteUsuExibSenha: boolean;

    TesteLojaPreenche: boolean;
    TesteLojaId: integer;
    TesteLojaApelido: string;

    TesteExecutaOk: boolean;

    procedure LerIni;
    procedure GravarIni;
    procedure Zerar;
    constructor Create(pPastaBin, pPastaConfigs: string);
    destructor Destroy; override;

  end;

implementation

uses System.IniFiles, System.SysUtils;

{ TConfigPergTeste }

constructor TConfigPergTeste.Create(pPastaBin, pPastaConfigs: string);
begin
  FPastaBin := pPastaBin;
  FPastaConfigs := pPastaConfigs;
  Zerar;
end;

destructor TConfigPergTeste.Destroy;
begin
  if CRIA_ARQ then
    GravarIni;
  inherited;
end;

procedure TConfigPergTeste.GravarIni;
var
  sNomeArq: string;
  IniFile: TIniFile;
begin
  sNomeArq := FPastaConfigs + 'testes.starter.ini';
  IniFile := TIniFile.Create(sNomeArq);
  try
    // MAQ LOCAL
    IniFile.WriteBool('form', 'maqlocal_buscanome', TesteMaqLocalBuscaNome);

    // SE É SERVIDOR
    IniFile.WriteBool('form', 'ehserver', TesteEhServ);

    // USUARIO ADMINISTRADOR
    IniFile.WriteBool('form', 'usu_admin_preenche', TesteUsuPreenche);
    IniFile.WriteString('form', 'usu_admin_nomecompleto',
      TesteUsuNomeCompleto);
    IniFile.WriteString('form', 'usu_admin_nomeexib', TesteUsuNomeExib);
    IniFile.WriteString('form', 'usu_admin_nomeusu', TesteUsuNomeUsu);
    IniFile.WriteString('form', 'usu_admin_senha1', TesteUsuSenha1);
    IniFile.WriteString('form', 'usu_admin_senha2', TesteUsuSenha2);
    IniFile.WriteBool('form', 'usu_admin_exibsenha', TesteUsuExibSenha);
    IniFile.WriteBool('form', 'executa_ok', TesteExecutaOk);


    // LOJA
    IniFile.WriteBool('form', 'loja_preenche', TesteLojaPreenche);
    IniFile.WriteInteger('form', 'loja_id', TesteLojaId);
    IniFile.WriteString('form', 'loja_apelido', TesteLojaApelido);
  finally
    IniFile.Free;
  end;
end;

procedure TConfigPergTeste.LerIni;
var
  sNomeArq: string;
  IniFile: TIniFile;
begin
  sNomeArq := FPastaConfigs + 'testes.starter.ini';
  if not FileExists(sNomeArq) then
  begin
    GravarIni;
    exit;
  end;

  IniFile := TIniFile.Create(sNomeArq);
  try
    // MAQ LOCAL
    TesteMaqLocalBuscaNome := IniFile.ReadBool('form',
      'maqlocal_buscanome', False);

    // SE É SERVIDOR
    TesteEhServ := IniFile.ReadBool('form', 'ehserver', False);

    // USUARIO ADMINISTRADOR
    TesteUsuPreenche := IniFile.ReadBool('form', 'usu_admin_preenche', False);
    TesteUsuNomeCompleto := IniFile.ReadString('form',
      'usu_admin_nomecompleto', '');
    TesteUsuNomeExib := IniFile.ReadString('form', 'usu_admin_nomeexib', '');
    TesteUsuNomeUsu := IniFile.ReadString('form', 'usu_admin_nomeusu', '');
    TesteUsuSenha1 := IniFile.ReadString('form', 'usu_admin_senha1', '');
    TesteUsuSenha2 := IniFile.ReadString('form', 'usu_admin_senha2', '');
    TesteUsuExibSenha := IniFile.ReadBool('form',
      'usu_admin_exibsenha', False);
    TesteExecutaOk := IniFile.ReadBool('form', 'executa_ok', False);

    // LOJA
    TesteLojaPreenche := IniFile.ReadBool('form', 'loja_preenche', False);
    TesteLojaId := IniFile.ReadInteger('form', 'loja_id', 0);
    TesteLojaApelido := IniFile.ReadString('form', 'loja_apelido', '');

  finally
    IniFile.Free;
  end;
end;

procedure TConfigPergTeste.Zerar;
begin
  TesteEhServ := False;
  TesteMaqLocalBuscaNome := False;

  TesteUsuPreenche := False;
  TesteUsuNomeCompleto := '';
  TesteUsuNomeExib := '';
  TesteUsuNomeUsu := '';
  TesteUsuSenha1 := '';
  TesteUsuSenha2 := '';
  TesteUsuExibSenha := False;

  TesteLojaPreenche := False;
  TesteLojaId := 0;
  TesteLojaApelido := '';
end;

end.
