unit App.AppObj;

interface

uses Sis.Config.SisConfig;

type
  IAppObj = interface(IInterface)
    ['{DC6EC674-3089-4213-8542-65232780AE51}']

    function GetSisConfig: ISisConfig;
    property SisConfig: ISisConfig read GetSisConfig;

    function Inicialize: boolean;
  end;

implementation

end.
