import java.util.ArrayList;
import java.util.Arrays;

public class App {
    public static void main(String[] args){

        Create arrivalOfPatients = new Create("Arrival of patients", Arrays.asList(15.0),  Arrays.asList("exp"), 1);

        Process reception = new Process("Reception", Arrays.asList(15.0, 40.0, 20.0),  Arrays.asList("", "", ""), 2);

        Process transitionWard = new Process("Transition to the ward", Arrays.asList(3.0, 3.0),  Arrays.asList("unif", ""), 3);
        transitionWard.setDelay(0, 8.0);

        Process referralLaboratory = new Process("Referral to the laboratory", Arrays.asList(2.0),  Arrays.asList("unif"), 1);
        referralLaboratory.setDelay(0, 5.0);

        Process registrationLaboratory = new Process("Registration in the laboratory", Arrays.asList(4.5),  Arrays.asList("erl"), 1);
        registrationLaboratory.setDelay(0, 3.0);

        Process passingLaboratory = new Process("Passing tests in the laboratory", Arrays.asList(4.0),  Arrays.asList("erl"), 2);
        passingLaboratory.setDelay(0, 2.0);

        Process returningRecaption= new Process("Returning to reception", Arrays.asList(2.0),  Arrays.asList("unif"), 1);
        passingLaboratory.setDelay(0, 5.0);

        arrivalOfPatients.setTransfer(Arrays.asList(reception));

        reception.setBlockers(new String[][]{{"flag", "1", "time", "7", "16"}, {"time", "7", "17"}});
        reception.setTransfer(Arrays.asList(transitionWard, referralLaboratory));

        transitionWard.setConditions(new String[][]{{"type", "1"}});

        referralLaboratory.setConditions(new String[][]{{"!type", "1"}});
        referralLaboratory.setTransfer(Arrays.asList(registrationLaboratory));

        registrationLaboratory.setTransfer(Arrays.asList(passingLaboratory));

        passingLaboratory.setTransfer(Arrays.asList(returningRecaption));

        returningRecaption.setConditions(new String[][]{{"type", "2"}});
        returningRecaption.setTransfer(Arrays.asList(reception));
        returningRecaption.setChanges(new String[][]{{"type", "1"}, {"flag", "1"}});

        ArrayList<Element> list = new ArrayList<>();
        list.add(arrivalOfPatients);
        list.add(reception);
        list.add(transitionWard);
        list.add(referralLaboratory);
        list.add(registrationLaboratory);
        list.add(passingLaboratory);
        list.add(returningRecaption);

        Model model = new Model(list);

        model.simulate(1000000.0);
    }
}
