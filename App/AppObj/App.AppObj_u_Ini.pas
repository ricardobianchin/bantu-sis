unit App.AppObj_u_Ini;

interface

uses App.AppObj, System.IniFiles;

procedure AppObjIniGravar(pAppObj: IAppObj);
procedure AppObjIniLer(pAppObj: IAppObj);

implementation

procedure AppObjIniGravar(pAppObj: IAppObj);
var
  oIniFile: TIniFile;
  sNomeArq: string;
begin
  sNomeArq := pAppObj.AppInfo.PastaConfigs + 'App.AppObj.ini';

  oIniFile := TIniFile.Create(sNomeArq);

  oIniFile.WriteInteger('loja', 'loja_id', pAppObj.Loja.Id);
  oIniFile.WriteString('loja', 'descr', pAppObj.Loja.Descr);
  oIniFile.WriteString('loja', 'apelido', pAppObj.Loja.Descr);

  oIniFile.WriteString('loja', 'nome', pAppObj.Loja.Nome);
  oIniFile.WriteString('loja', 'nome_fantasia', pAppObj.Loja.NomeFantasia);

  oIniFile.WriteString('loja', 'c', pAppObj.Loja.C);
  oIniFile.WriteString('loja', 'i', pAppObj.Loja.I);
  oIniFile.WriteString('loja', 'm', pAppObj.Loja.M);
  oIniFile.WriteString('loja', 'm_uf', pAppObj.Loja.MUF);

  oIniFile.WriteString('loja', 'email', pAppObj.Loja.EMail);

  oIniFile.WriteString('loja', 'logradouro', pAppObj.Loja.Ender.Logradouro);
  oIniFile.WriteString('loja', 'numero', pAppObj.Loja.Ender.Numero);
  oIniFile.WriteString('loja', 'complemento', pAppObj.Loja.Ender.Complemento);
  oIniFile.WriteString('loja', 'bairro', pAppObj.Loja.Ender.Bairro);
  
  oIniFile.WriteString('loja', 'municipio_ibge_id', pAppObj.Loja.Ender.MunicipioIbgeId);
  oIniFile.WriteString('loja', 'municipio_nome', pAppObj.Loja.Ender.MunicipioNome);

  oIniFile.WriteString('loja', 'uf_sigla', pAppObj.Loja.Ender.UFSigla);
  oIniFile.WriteString('loja', 'cep', pAppObj.Loja.Ender.CEP);

  oIniFile.WriteString('loja', 'ddd', pAppObj.Loja.Ender.DDD);
  oIniFile.WriteString('loja', 'fone1', pAppObj.Loja.Ender.Fone1);
  oIniFile.WriteString('loja', 'fone2', pAppObj.Loja.Ender.Fone2);
  oIniFile.WriteString('loja', 'fone3', pAppObj.Loja.Ender.Fone3);

  oIniFile.WriteString('loja', 'contato', pAppObj.Loja.Ender.Contato);
  oIniFile.WriteString('loja', 'referencia', pAppObj.Loja.Ender.Referencia);

  oIniFile.WriteInteger('machine', 'server', pAppObj.SisConfig.ServerMachineId.IdentId);
  oIniFile.WriteInteger('machine', 'local', pAppObj.SisConfig.LocalMachineId.IdentId);

  oIniFile.Free;
end;

procedure AppObjIniLer(pAppObj: IAppObj);
var
  oIniFile: TIniFile;
  sNomeArq: string;
begin
  sNomeArq := pAppObj.AppInfo.PastaConfigs + 'App.AppObj.ini';

  oIniFile := TIniFile.Create(sNomeArq);

  pAppObj.Loja.Id := oIniFile.ReadInteger('loja', 'loja_id', 0);
  pAppObj.Loja.Descr := oIniFile.ReadString('loja', 'descr', '');
  pAppObj.Loja.Apelido := oIniFile.ReadString('loja', 'apelido', '');

  pAppObj.Loja.Nome := oIniFile.ReadString('loja', 'nome', '');
  pAppObj.Loja.NomeFantasia := oIniFile.ReadString('loja', 'nome_fantasia', '');

  pAppObj.Loja.C := oIniFile.ReadString('loja', 'c', '');
  pAppObj.Loja.I := oIniFile.ReadString('loja', 'i', '');
  pAppObj.Loja.M := oIniFile.ReadString('loja', 'm', '');
  pAppObj.Loja.MUF := oIniFile.ReadString('loja', 'm_uf', '');

  pAppObj.Loja.EMail := oIniFile.ReadString('loja', 'email', '');

  pAppObj.Loja.Ender.Logradouro := oIniFile.ReadString('loja', 'logradouro', '');
  pAppObj.Loja.Ender.Numero := oIniFile.ReadString('loja', 'numero', '');
  pAppObj.Loja.Ender.Complemento := oIniFile.ReadString('loja', 'complemento', '');
  pAppObj.Loja.Ender.Bairro := oIniFile.ReadString('loja', 'bairro', '');

  pAppObj.Loja.Ender.MunicipioIbgeId := oIniFile.ReadString('loja', 'municipio_ibge_id', '');
  pAppObj.Loja.Ender.MunicipioNome := oIniFile.ReadString('loja', 'municipio_nome', '');

  pAppObj.Loja.Ender.UFSigla := oIniFile.ReadString('loja', 'uf_sigla', '');
  pAppObj.Loja.Ender.CEP := oIniFile.ReadString('loja', 'cep', '');

  pAppObj.Loja.Ender.DDD := oIniFile.ReadString('loja', 'ddd', '');
  pAppObj.Loja.Ender.Fone1 := oIniFile.ReadString('loja', 'fone1', '');
  pAppObj.Loja.Ender.Fone2 := oIniFile.ReadString('loja', 'fone2', '');
  pAppObj.Loja.Ender.Fone3 := oIniFile.ReadString('loja', 'fone3', '');

  pAppObj.Loja.Ender.Contato := oIniFile.ReadString('loja', 'contato', '');
  pAppObj.Loja.Ender.Referencia := oIniFile.ReadString('loja', 'referencia', '');

  pAppObj.SisConfig.ServerMachineId.IdentId := oIniFile.ReadInteger('machine', 'server', 0);
  pAppObj.SisConfig.LocalMachineId.IdentId := oIniFile.ReadInteger('machine', 'local', 0);

  oIniFile.Free;
end;


end.
