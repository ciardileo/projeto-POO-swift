// Academia Dia 3

// Códigos do Dia 1 e 2

// CÓDIGO DIA 1
// modelagem de PESSOA

enum NivelAluno: String {
    case iniciante
    case intermediario
    case avancado
}


class Pessoa {
    public var nome: String
    public var email: String

    init(_ nome: String, _ email: String) {
        self.nome = nome
        self.email = email
    }

    public func getDescricao() -> String {
        return "Nome: \(nome)\nEmail: \(email)"
    }

}

class Aluno: Pessoa {
    public let matricula: String
    public var nivel: NivelAluno
    private(set) var plano: Plano

    init(_ nome: String, _ email: String, _ matricula: String, _ nivel: NivelAluno, _ plano: Plano) {
        self.matricula = matricula
        self.nivel = nivel
        self.plano = plano
        super.init(nome, email)
    }

    override public func getDescricao() -> String {
        return super.getDescricao() + "\nMatrícula: \(self.matricula)\nNível: \(self.nivel.rawValue)\nPlano: \(self.plano.nome)"
    }
}

class Instrutor: Pessoa {
    public var especialidade: String  

    init(_ nome: String, _ email: String, _ especialidade: String) {
        self.especialidade = especialidade
        super.init(nome, email)
    }

    override public func getDescricao() -> String {
        return super.getDescricao() + "\nEspecialidade: \(self.especialidade)"
    }
}


// modelagem de PLANO
class Plano {  // deveria ser uma classe abstrata
    public var nome: String

    init(_ nome: String) {
        self.nome = nome
    }   

    public func calcularMensalidade() -> Double {
        return 0.0
    }
}


class PlanoMensal: Plano {
    init() {
        super.init("")  // inicializa a variável nome
        self.nome = "Plano Mensal"
    }

    override public func calcularMensalidade() -> Double {
        return 120.0
    }
}


class PlanoAnual: Plano {
    init() {
        super.init("")
        self.nome = "Plano Anual (Promocional)"
    }

    override public func calcularMensalidade() -> Double {
        return ((120.0 * 12.0) * 0.8) / 12.0
    }
}

// CÓDIGO DIA 2

protocol Manutencao {
    var nomeItem: String {get set}
    var dataUltimaManutencao: String {get}
    
    func realizarManutencao() -> Bool
}


class Aparelho: Manutencao {
    public var nomeItem: String
    private(set) var dataUltimaManutencao: String

    init(nome: String) {
        self.nomeItem = nome
        self.dataUltimaManutencao = "Nenhuma"
    }

    public func realizarManutencao() -> Bool {
        print("Data de \(self.nomeItem) atualizado para 03/12/2025")
        self.dataUltimaManutencao = "03/12/2025"

        return true
    }
}


class Aula {
    public var nome: String
    public var instrutor: Instrutor

    init(_ nome: String, _ instrutor: Instrutor) {
        self.nome = nome
        self.instrutor = instrutor
    }

    public func getDescricao() -> String {
        return "Aula \(self.nome) com o instrutor \(self.instrutor.nome)"
    }
}

class AulaPersonal: Aula {
    public var aluno: Aluno

    init(_ nome: String, _ instrutor: Instrutor, _ aluno: Aluno) {
        self.aluno = aluno
        super.init(nome, instrutor)
    }


   override public func getDescricao() -> String {
        return super.getDescricao() + " e com o aluno \(self.aluno.nome)"
   } 
}


class AulaColetiva: Aula {
    private(set) var alunosInscritos: [String: Aluno]
    public let capacidadeMaxima: Int

    init(_ nome: String, _ instrutor: Instrutor, _ capacidadeMaxima: Int) {
        self.capacidadeMaxima = capacidadeMaxima
        self.alunosInscritos = [:]  // dicionário vazio
        super.init(nome, instrutor)
    } 

    // COMENTÁRIO 2: mudamos o return para uma tupla com um success (boolean) e uma mensagem de erro, pois assim é possível identificar o erro de forma clara e ter uma mensagem específica
    public func inscrever(_ aluno: Aluno) -> (success: Bool, msg: String) {
        // se ainda houver espaço na turma
        if (self.alunosInscritos.count < self.capacidadeMaxima) {
            // se o aluno ainda não estiver inscrito
            if (!self.alunosInscritos.keys.contains(aluno.matricula)) {
                self.alunosInscritos[aluno.matricula] = aluno
                return (success: true, msg: "Sucesso! Aluno \(aluno.nome) adicionado com sucesso!")
            } else {
                return (success: false, msg: "Erro! O aluno \(aluno.nome) já está inscrito!")
            }
        } else {
            return (success: false, msg: "Erro! Não há espaço suficiente na turma!")
        }
    }


    override public func getDescricao() -> String {
        return super.getDescricao() + ". Vagas disponíveis: (\(self.alunosInscritos.count)/\(self.capacidadeMaxima))"
    }
}


// CÓDIGOS DIA 3

class Academia {
    private let nome: String 
    private var alunosMatriculados: [String: Aluno]
    private var instrutoresContratados: [String: Instrutor]
    private var aparelhos: [Aparelho]
    private var aulasDisponiveis: [Aula]

    init(nome: String) {
        self.nome = nome
        self.alunosMatriculados = [:]
        self.instrutoresContratados = [:]
        self.aparelhos = []
        self.aulasDisponiveis = []
    }


    public func adicionarAparelho(_ aparelho: Aparelho) -> Bool {
        self.aparelhos.append(aparelho)
        return true
    }


    public func adicionarAula(_ aula: Aula) -> Bool {
        self.aulasDisponiveis.append(aula)
        return true
    }


    public func contratarInstrutor(_ instrutor: Instrutor) -> Bool{
        self.instrutoresContratados[instrutor.email] = instrutor
        return true
    }

    // sobrecarga de métodos
    public func matricularAluno(_ aluno: Aluno) -> (success: Bool, msg: String) {
        if (!self.alunosMatriculados.keys.contains(aluno.matricula)) {
            self.alunosMatriculados[aluno.matricula] = aluno
            return (success: true, msg: "Sucesso! Aluno de matrícula \(aluno.matricula) matriculado na academia")
        } else {
            return (success: false, msg: "Erro! O aluno de matrícula \(aluno.matricula) já está matriculado na academia")
        }
    }


    public func matricularAluno(nome: String, email: String, matricula: String, nivel: NivelAluno, plano: Plano) -> Aluno? {
        let novoAluno = Aluno(nome, email, matricula, nivel, plano)
        let respostaMatricula = matricularAluno(novoAluno)

        if (respostaMatricula.success) {
            return novoAluno
        } else {
            return nil
        }
    }


    public func buscarAluno(porMatricula matricula: String) -> Aluno? {
        if let aluno = self.alunosMatriculados[matricula] {
            return aluno
        } else {
            return nil
        }
    } 

     public func listarAlunos() {
        if (self.alunosMatriculados.isEmpty) {
            print ("Não há alunos matriculados")
        } else {
            let alunosOrdenados = self.alunosMatriculados.values.sorted { $0.nome < $1.nome }
            for aluno in alunosOrdenados {
                print (aluno.getDescricao())
                print ("")
            }
        }
    }
    
     /* OUTRA FORMA ENCONTRADA DE REALIZAR A LISTAGEM DE ALUNOS
    public func listarAlunos() {
    print("=================================")
    print("Data: 05/12/2025")
    print("Academia: \(nome)")
    print("=================================")
        if alunosInscritos.isEmpty {
            print("Erro: Nenhum aluno matriculado!")
            return
        }

        print("--- Lista de Alunos Matriculados (A–Z) ---")

        let alunosOrdenados = alunosInscritos.values.sorted {
            $0.nome.lowercased() < $1.nome.lowercased()
        }

        for aluno in alunosOrdenados {
            print(aluno.getDescricao())
            print("----------/ Swift /----------")
        }
    }
    */
    
    public func listarAulas() {
        if (self.aulasDisponiveis.isEmpty) {
            print ("Nenhuma aula disponivel no momento")
        } else {
            for aula in self.aulasDisponiveis {
                print(aula.getDescricao())
                print ("")
            }
        }
    }
   
    
    /* OUTRA FORMA PENSADA PARA A LISTAGEM DE AULAS
     public func listarAulas() {
    print("=================================")
     print("Data: 05/12/2025")
    print("Academia: \(nome)")
    print("=================================")
    if aulasDisponiveis.isEmpty {
        print("Nenhuma aula cadastrada!")
        return
    }
    
    print("=== Aulas Disponíveis ===")
    
    for aula in aulasDisponiveis {
        print(aula.getDescricao())
            print("----------/ Swift /----------")
    }
}
    
    */
    
}
let academia = Academia(nome: "Academia teste")
let planoMes = PlanoMensal()
let PlanoAno = PlanoAnual()
let instrutor1 = Instrutor("José", "joseTrapezio@gmail.com", "trapezios")
let instrutor2 = Instrutor("Camila", "camilaOmbro@gmail.com", "Ombro")


academia.contratarInstrutor(instrutor1)
academia.contratarInstrutor(instrutor2)

let aluno1 = Aluno("Joao", "joaozinho@gmail.com", "SM1234567", .iniciante, planoMes)
let aluno2 = Aluno("Paulo", "paulozinho@gmail.com", "SM7654321", .intermediario, PlanoAno)

academia.matricularAluno(aluno1)
academia.matricularAluno(aluno2)

let aulaFocada = AulaPersonal("do Paulo", instrutor2, aluno2)
let aulaGeral = AulaColetiva("pra geral", instrutor1, 3)

academia.adicionarAula(aulaFocada)
academia.adicionarAula(aulaGeral)


let aluno3 = Aluno("Ana", "Ana@gmail.com", "SM1234765", .intermediario, planoMes)
academia.matricularAluno(aluno3)


let aluno4 = Aluno("Diego", "Riviera@gmail.com", "SM4321567", .iniciante, PlanoAno)
academia.matricularAluno(aluno4)

print(aulaGeral.inscrever(aluno1).msg)
print(aulaGeral.inscrever(aluno2).msg)
print(aulaGeral.inscrever(aluno3).msg)
print(aulaGeral.inscrever(aluno4).msg)

academia.listarAulas()
academia.listarAlunos()

var aulas: [Aula] = [aulaFocada, aulaGeral]
for aula in aulas {
    print(aula.getDescricao())
    print("")
}

var pessoa: [Pessoa] = [instrutor1, aluno1, aluno2, aluno3, instrutor2, aluno4]
for j in pessoa {
    print(j.getDescricao())
    print("")
}

extension Academia {
    func gerarRelatorio() -> (totalAlunos: Int, totalInstrutores: Int, totalAulas: Int){
        return (totalAlunos: academia.alunosMatriculados.count, totalInstrutores: academia.instrutoresContratados.count, totalAulas: academia.aulasDisponiveis.count)
    }
    
}

let relatorio = academia.gerarRelatorio()
print("Relatório da Academia:")
print("Total de Alunos Matriculados: \(relatorio.totalAlunos)")
print("Total de Instrutores Contratados: \(relatorio.totalInstrutores)")
print("Total de Aulas Disponíveis: \(relatorio.totalAulas)")
