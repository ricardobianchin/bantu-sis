unit App.UI.Config.ConfigForm.Testes;

interface

const
  CRIA_ARQ = False;

type
  TTesteConfig = class(TObject)
  private
    FPastaBin: string;

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

    procedure LerIni;
    procedure GravarIni;
    procedure Zerar;
    constructor Create(pPastaBin: string);
    destructor Destroy; override;

  end;

implementation

uses System.IniFiles, System.SysUtils;

{ TTesteConfig }

constructor TTesteConfig.Create(pPastaBin: string);
begin
  FPastaBin := pPastaBin;
  Zerar;
end;

destructor TTesteConfig.Destroy;
begin
  if CRIA_ARQ then
    GravarIni;
  inherited;
end;

procedure TTesteConfig.GravarIni;
var
  sNomeArq: string;
  IniFile: TIniFile;
begin
  sNomeArq := FPastaBin + 'testes.starter.ini';
  IniFile := TIniFile.Create(sNomeArq);
  try
    // MAQ LOCAL
    IniFile.WriteBool('form', 'maqlocal_buscanome', TesteMaqLocalBuscaNome);

    // SE É SERVIDOR
    IniFile.WriteBool('form', 'ehserver', TesteEhServ);

    // USUARIO GERENTE
    IniFile.WriteBool('form', 'usugerente_preenche', TesteUsuPreenche);
    IniFile.WriteString('form', 'usugerente_nomecompleto',
      TesteUsuNomeCompleto);
    IniFile.WriteString('form', 'usugerente_nomeexib', TesteUsuNomeExib);
    IniFile.WriteString('form', 'usugerente_nomeusu', TesteUsuNomeUsu);
    IniFile.WriteString('form', 'usugerente_senha1', TesteUsuSenha1);
    IniFile.WriteString('form', 'usugerente_senha2', TesteUsuSenha2);
    IniFile.WriteBool('form', 'usugerente_exibsenha', TesteUsuExibSenha);

    // LOJA
    IniFile.WriteBool('form', 'loja_preenche', TesteLojaPreenche);
    IniFile.WriteInteger('form', 'loja_id', TesteLojaId);
    IniFile.WriteString('form', 'loja_apelido', TesteLojaApelido);
  finally
    IniFile.Free;
  end;
end;

procedure TTesteConfig.LerIni;
var
  sNomeArq: string;
  IniFile: TIniFile;
begin
  sNomeArq := FPastaBin + 'testes.starter.ini';
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

    // USUARIO GERENTE
    TesteUsuPreenche := IniFile.ReadBool('form', 'usugerente_preenche', False);
    TesteUsuNomeCompleto := IniFile.ReadString('form',
      'usugerente_nomecompleto', '');
    TesteUsuNomeExib := IniFile.ReadString('form', 'usugerente_nomeexib', '');
    TesteUsuNomeUsu := IniFile.ReadString('form', 'usugerente_nomeusu', '');
    TesteUsuSenha1 := IniFile.ReadString('form', 'usugerente_senha1', '');
    TesteUsuSenha2 := IniFile.ReadString('form', 'usugerente_senha2', '');
    TesteUsuExibSenha := IniFile.ReadBool('form',
      'usugerente_exibsenha', False);

    // LOJA
    TesteLojaPreenche := IniFile.ReadBool('form', 'loja_preenche', False);
    TesteLojaId := IniFile.ReadInteger('form', 'loja_id', 0);
    TesteLojaApelido := IniFile.ReadString('form', 'loja_apelido', '');

  finally
    IniFile.Free;
  end;
end;

procedure TTesteConfig.Zerar;
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
