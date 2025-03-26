unit Sis.Web.HTTPGet.Net_u;

interface


uses Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, System.Classes;

procedure BuscarCepViaWeb(const Cep: string; pSL: TStrings);

//temporario. deve ser cirado httpget e no factory decide qual instanciar, por exemplo, httpgetnet

implementation

uses
  System.NET.HttpClient, System.NET.URLClient, System.SysUtils,
  Sis.Types.Dates, Sis.UI.IO.Files.Sync, System.IOUtils, dialogs;

procedure BuscarCepViaWeb(const Cep: string; pSL: TStrings);
var
  HttpClient: THTTPClient;
  Response: IHTTPResponse;
  Url: string;
begin
  pSL.Clear;

//  psl.Add('{');
//  psl.Add('"cep": "23070-221",');
//  psl.Add('"logradouro": "Estrada do Campinho",');
//  psl.Add('"complemento": "até 2995 - lado ímpar",');
//  psl.Add('"bairro": "Campo Grande",');
//  psl.Add('"localidade": "Rio de Janeiro",');
//  psl.Add('"uf": "RJ",');
//  psl.Add('"ibge": "3304557"');
//  psl.Add('}');
//
//  exit;

  Url := 'https://opencep.com/v1/' + Cep; // Substitua pela URL da API de CEP que você deseja usar

  HttpClient := THTTPClient.Create;
  try
    Response := HttpClient.Get(Url);
    if Response.StatusCode = 200 then // Verifica se a requisição foi bem-sucedida
    begin
      // Processa a resposta (por exemplo, extraindo informações do JSON)
      // ...
      //ShowMessage('CEP encontrado: ' + Response.ContentAsString);
      pSL.Text := Response.ContentAsString;
    end
    else
    begin
      //ShowMessage('Erro ao buscar o CEP. Status: ' + IntToStr(Response.StatusCode));
    end;
  finally
    HttpClient.Free;
  end;
end;

end.
