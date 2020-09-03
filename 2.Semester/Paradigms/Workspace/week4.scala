object week_4_lecture {
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
        return false
      }
  }

  val F1 = find(Cons(3,Cons(10,Cons(7,Nil()))),10)
  val F2 = find (L,10)

  def fold(list: IntList, seed: Int, func: (Int,Int) => Int): Int = list match {
    case Nil() => return seed
    case Cons(headd, tail) => return fold(tail,func(head,seed),func) 
  }

}