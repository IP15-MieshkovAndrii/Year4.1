import java.util.ArrayList;

public class Model {
    private double tNext = 0;
    private double tCurr = 0;
    private ArrayList<Element> list = new ArrayList<>();

    public Model(ArrayList<Element> elements) {
        list = elements;
    }

    public void simulate(double time) {
        while (this.tCurr < time) {
            this.tNext = Double.MAX_VALUE;
            for (Element e : list) {
                if ((e.getTnext() < this.tNext)) {
                    this.tNext = e.getTnext();
                }
            }
            for (Element e : list) {
                e.doStatistics(tNext - tCurr);
            }
            this.tCurr = this.tNext;
            for (Element e : list) {
                e.setTcurr(tCurr);
            }
            for (Element e : list) {
                if (e.getTnext() == this.tCurr) {
                    e.outAct();
                }
            }
        }
        printResult();
    }

    public void printResult() {
        System.out.println("\n-------------RESULTS-------------");
        for (Element e : list) {
            e.printResult();
        }
    }
}
