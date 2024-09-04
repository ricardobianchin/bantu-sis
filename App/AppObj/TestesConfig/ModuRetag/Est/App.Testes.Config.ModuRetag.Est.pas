unit App.Testes.Config.ModuRetag.Est;

interface

uses App.Testes.Config.ModuRetag.Est.Cliente;

type
  ITesteConfigModuRetagEst = interface(IInterface)
    ['{99D51077-7BB5-4B6A-A275-2D46462E6CA2}']
    function GetCliente: ITesteConfigModuRetagEstCliente;
    property Cliente: ITesteConfigModuRetagEstCliente read GetCliente;
  end;

implementation

end.
