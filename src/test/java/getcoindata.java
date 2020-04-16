import org.apache.commons.io.FileUtils;
import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.Assert.assertTrue;

@KarateOptions(tags = {"@getbtc"})
public class getcoindata
{

    @BeforeClass
    public static void before() {
        System.setProperty("karate.env", "stage");
    }

    @Test
    public void getbtcData() {
        Results results = Runner.parallel(getClass(), 1);
        System.out.println("Path is:-----"+results.getReportDir());
        generateReport(results.getReportDir());
        Assert.assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }

    private static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "karate-apollo");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
