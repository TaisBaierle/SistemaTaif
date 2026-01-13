unit CarroDAO;

interface

uses
  SysUtils,
  FireDAC.Comp.Client,
  SistemaSorteioData,
  Carro,
  UDFUtils;

type
  TCarroDAO = class
  public
    procedure Inserir(const ACarro: TCarro);
  end;

implementation

procedure TCarroDAO.Inserir(const ACarro: TCarro);
begin
  dmSistemaSorteio.InserirDadosBD
    ('INSERT INTO CARRO (IDCARRO, MODELO, DATALANCAMENTO) ' +
    'VALUES (:ID, :MODELO, :DATA)', [ACarro.IdCarro, ACarro.Modelo,
    UDFUtils.GerarDataAleatoria]);

end;

end.
