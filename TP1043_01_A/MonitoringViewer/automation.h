#ifndef AUTOMATION_H
#define AUTOMATION_H

#include "main.h"
#include "hmi_logger.h"
#include "global_functions.h"

void setup(void);
void loop(void);

// ---------------------------------------

#include <QString>
#include <QStringList>
#include <QLabel>

#define MAX_VARS 9

const QString trendsPath =
#ifdef Q_WS_QWS
    "/local/data/customtrend"
#elif defined(Q_OS_LINUX)
    "customtrend"
#elif defined(Q_OS_WIN)
    "customtrend"
#else
    "customtrend"
#endif
;

struct trendVariable {
    // file trend.csv
    QString name;
    QString color;
    double min;
    double max;
    QString descr;
    // ui
    QLabel *labelName;
    QLabel *labelValue;
    // crosstable
    unsigned id;
    double value;
};

QStringList getTrendList();
void initVars(trendVariable vars[MAX_VARS], QLabel *names[], QLabel *values[]);
void clearVars(struct trendVariable vars[MAX_VARS]);
bool setupVars(struct trendVariable vars[MAX_VARS], const QString trendName, bool isHorizontal);
void updateVars(struct trendVariable vars[MAX_VARS]);


#endif // AUTOMATION_H

