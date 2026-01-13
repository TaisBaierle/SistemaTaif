unit Cliente;

interface

type
  TCliente = class
  private
    FIdCliente: Integer;
    FNome: string;
    FCPFCNPJ: string;
    FDataCadastro: TDate;
  public
    property IdCliente: Integer read FIdCliente write FIdCliente;
    property Nome: string read FNome write FNome;
    property CPFCNPJ: string read FCPFCNPJ write FCPFCNPJ;
    property DataCadastro: TDate read FDataCadastro write FDataCadastro;
  end;

implementation

end.

