import React from 'react';
import {Box, Grid, Tab, Tabs, Typography} from '@material-ui/core';
import {Content, InfoCard, Page,} from '@backstage/core-components';
import {CatalogComponent} from "./CatalogComponent";
import {RequestStatus} from "./RequestStatus";

interface TabPanelProps {
    children?: React.ReactNode;
    index: number;
    value: number;
}

function CustomTabPanel(props: TabPanelProps) {
    const { children, value, index, ...other } = props;

    return (
        <div
            role="tabpanel"
            hidden={value !== index}
            id={`simple-tabpanel-${index}`}
            aria-labelledby={`simple-tab-${index}`}
            {...other}
        >
            {value === index && <Box sx={{ p: 3 }}>{children}</Box>}
        </div>
    );
}

function a11yProps(index: number) {
    return {
        id: `simple-tab-${index}`,
        'aria-controls': `simple-tabpanel-${index}`,
    };
}

export const ExampleComponent = () => {
    const [value, setValue] = React.useState(0);

    // @ts-ignore
    const handleChange = (event: React.ChangeEvent<{}>, newValue: number) => {
        setValue(newValue);
    };

    return (
        <Page themeId="tool">
            <Content>
                <Grid container spacing={3} direction="column">
                    <Grid item>
                        <InfoCard title="Self Service Portal">
                            <Typography variant="body1">
                                Some general information
                            </Typography>
                        </InfoCard>
                    </Grid>
                    <Grid item>

                        <Box sx={{borderBottom: 1, borderColor: 'divider'}}>
                            <Tabs value={value} onChange={handleChange} aria-label="basic tabs example">
                                <Tab label="Catalog" {...a11yProps(0)} />
                                <Tab label="Status" {...a11yProps(1)} />
                            </Tabs>
                        </Box>
                        <CustomTabPanel value={value} index={0}>
                            <CatalogComponent/>
                        </CustomTabPanel>
                        <CustomTabPanel value={value} index={1}>
                            <RequestStatus />
                        </CustomTabPanel>
                    </Grid>
                </Grid>
            </Content>
        </Page>
    )
};
