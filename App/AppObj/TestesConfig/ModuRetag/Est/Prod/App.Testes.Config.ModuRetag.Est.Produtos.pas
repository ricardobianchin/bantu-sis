unit App.Testes.Config.ModuRetag.Est.Produtos;

interface

type
  ITesteConfigModuRetagEstProdutos = interface(IInterface)
    ['{FF6D9DA7-5FD3-4000-8CE6-88F42F718E37}']
    function GetAutoExec: boolean;
    procedure SetAutoExec(Value: boolean);
    property AutoExec: boolean read GetAutoExec write SetAutoExec;
  end;

implementation

end.
