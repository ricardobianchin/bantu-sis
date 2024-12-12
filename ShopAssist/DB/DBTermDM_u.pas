unit DBTermDM_u;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client;

type
  TTerminal = record
    TerminalId: smallint;
    NomeNaRede: string;
    LocalArqDados: string;
  end;

  TDBTermDM = class(TDataModule)
    Connection: TFDConnection;
  private
    { Private declarations }
  public
    { Public declarations }
    Terminal: TTerminal;
  end;

  TProcTermOfObject = procedure(pTermDM: TDBTermDM;
    var pPrecisaTerminar: Boolean) { of object };

  // var
  // DBTermDM: TDBTermDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

end.
