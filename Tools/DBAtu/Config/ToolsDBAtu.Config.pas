unit ToolsDBAtu.Config;

interface
//aqui deve ter uma interface chamada IToolsDBAtuConfig com somente uma propriedade chamada arq_type_balancaPas: string
// nao arq_type_balanca_pas
type
  IToolsDBAtuConfig = interface
   ['{BF47C003-A01C-4690-90CD-4B8B420B9299}']
    function GetArqTypeBalancaPas: string;
    procedure SetArqTypeBalancaPas(const Value: string);
    property ArqTypeBalancaPas: string read GetArqTypeBalancaPas write SetArqTypeBalancaPas;
  end;

implementation

end.
