unit App.Entidade.Ed.Unid;

interface

uses App.Entidade.Ed.Id.Descr;

type
  IEntUnid = interface(IEntIdDescr)
    ['{E534367C-5868-4338-A3EF-A879CA7E08EF}']
    function GetSigla: string;
    procedure SetSigla(Value: string);
    property Sigla: string read GetSigla write SetSigla;

  end;


implementation

end.
