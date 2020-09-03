  sealed abstract class IntList;
  case class Nil() extends IntList;
  case class Cons(hd: Int, tl:IntList) extends IntList;

  val L = Cons(1, Cons(2, Nil()))

  def addAll(list: IntList): Int = list match{
    case Nil() => return 0;
    case Cons(head,tail) => return head+ addAll(tail)
  }

  val R1 = addAll(L)
  val R2 = addAll(Cons(7,L))

  def find(list: IntList, value: Int): Boolean = list match {
    case Nil() => return false
    case Cons(head,tail) =>
      if (head == value){
        return true
      } else {
        return find(tail,value)
      }
  }

  val F1 = find(Cons(3,Cons(10,Cons(7,Nil()))),10)
  val F2 = find (L,10)

  def fold(list: IntList, seed: Int, func: (Int,Int) => Int): Int = list match {
    case Nil() => return seed
    case Cons(head, tail) => return fold(tail,func(head,seed),func)
  }

  def addAllAcc(list: IntList, acc:Int): Int = list match {
    case Nil() => acc
    case Cons(head,tail) => addAllAcc(tail,head+acc)
  }

  def add(x: Int, y:Int): Int = {
    return x+y
  }

  def addAll1(list: IntList) = fold(list,0,add)

  val R1_1 = addAll1(L)
  val R1_2 = addAll1(Cons(7,L))

  def addAll2(list: IntList) = fold(list,0,(x,y) => x + y)

  val R2_1 = addAll2(L)
  val R2_2 = addAll2(Cons(7,L))

  def map(list: IntList, seed: Int, func: Int => Int, cont: IntList => IntList): IntList = list match {
    case Nil() => return Nil()
    case Cons(head,tail) => return Cons(func(head),map(tail,seed,func))
  }

  def mapc(list: IntList, func: Int => Int, cont: IntList => IntList): IntList = list match {
    case Nil() => c
  }
